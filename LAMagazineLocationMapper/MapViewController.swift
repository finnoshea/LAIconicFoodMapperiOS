//
//  MapViewController.swift
//  LAMagazineLocationMapper
//
//  Created by Finn on 4/13/17.
//  Copyright © 2017 Finn. All rights reserved.
//  For info on centering the map on the user, see: http://stackoverflow.com/questions/40054883/current-location-in-not-working-in-google-map/40058423#40058423
//  Or better yet, here: http://stackoverflow.com/questions/39430399/google-maps-ios-mylocation
//  Or maybe here: http://stackoverflow.com/questions/26192480/cannot-get-my-location-to-show-up-in-google-maps-in-ios-8

import UIKit
import GoogleMaps
import os.log

class MapViewController: UIViewController {
    
    //MARK: Properties
    // an array of the items
    var items = [Item]()
    var mapView: GMSMapView!
    var markers = [GMSMarker]()
    // where the camera should start - uses default location
    var startCamera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 34.1,
                                                                  longitude: -118.3,
                                                                  zoom: 11)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Use this because it is called every time the view appears, not just when it is loaded like viewDidLoad
        
        super.viewWillAppear(animated)
        
        // create the map view property
        let mapView = GMSMapView(frame: .zero)
        
        // try to load the users location
        // The myLocation attribute of the mapView may be nil
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        if let myLocation = mapView.myLocation {
            print("User's location: \(myLocation)")
            startCamera = GMSCameraPosition.camera(withTarget:myLocation.coordinate,
                                                   zoom: 11)
        } else {
            // otherwise use the default location
            print("User's location is unknown")
        }
        
        
        // generate the map view
        mapView.camera = startCamera
        view = mapView
        
        // load the items from memory or, failing that, the default items
        safeLoadItems()
        
        // put the markers on the map
        mapMarkers(for: mapView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // Google's SDK guide uses this function, but Apple says never to use it in this way
    // Keeping it here for shame points
    override func loadView() {
    }
    */
    
    // Override the navigation controller setting that names a push-navigation button to
    // this view controller's title.  Use 'back' instead.
    // http://stackoverflow.com/questions/28471164/how-to-set-back-button-text-in-swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Map"
        navigationItem.backBarButtonItem = backItem
        // This will show in the next view controller being pushed
    }
    
    // MARK: Private Methods
    
    private func safeLoadItems(){
        items.removeAll() // clear out the items property
        // checks to see if a items file exists, if not, load the defaults
        // load the items from memory, if that fails, use the sample items
        if let savedItems = loadItems() {
            items += savedItems
            //os_log("Items successfully loaded.", log: OSLog.default, type: .debug)
            if items.count < 100 {
                items.removeAll()
                items = initializeItemData()
                //os_log("Saved list is incomplete, loading initial data.", log: OSLog.default, type: .debug)
            }
        }
        else {
            // Load the all the items on first load.
            items = initializeItemData()
            //os_log("Items loaded from internal memory.", log: OSLog.default, type: .debug)
        }
    }
    
    private func loadItems() -> [Item]? {
        // load the items from the table view
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
    
    private func mapMarkers(for mapView: GMSMapView) {
        
        // clear out the marker property first, otherwise the older markers cover the new ones
        markers.removeAll()
        // then clear the map of markers
        mapView.clear()
        // fill the map with markers by going through the list of items
        var counter = 0
        for ii in 0..<items.count {
            // check to see if the title already exists in the array of markers
            if let theIndexes: [Int] = containsTitle(for: markers, name: items[ii].name) {
                // if so, add the item number and name to the snippet for those items
                for jj in theIndexes {
                    let oldSnippet = markers[jj].snippet!
                    markers[jj].snippet = oldSnippet + "\n" + "\(items[ii].number): \(items[ii].item)"
                    if !items[ii].visited {
                        // if the new item hasn't been tried (visited = false), set the pin red and the flag false
                        markers[jj].icon = GMSMarker.markerImage(with: .red)
                    }
                }
            } else {  // add the items to the GMSMarker list
                // testing in playground tells me the following line should fail when the
                // items[ii-1].coords.count is 1, but it appears to be working
                for jj in 0..<items[ii].coords.count {
                    let tempMarker = GMSMarker()
                    let coordinates = items[ii].coords[jj].components(separatedBy: ",")
                    tempMarker.position = CLLocationCoordinate2D(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!)
                    // title the marker with the item number and the name
                    tempMarker.title = items[ii].name
                    // add the name of the item to the marker when tapped
                    tempMarker.snippet = "\(items[ii].number): \(items[ii].item)"
                    
                    if items[ii].visited {
                        // if the place has been visited, change the marker to green
                        tempMarker.icon = GMSMarker.markerImage(with: .green)
                    } else {
                        // otherwise, set the marker to red
                        tempMarker.icon = GMSMarker.markerImage(with: .red)
                    }
                    markers.append(tempMarker) // append the marker to the variable
                    markers[counter].map = mapView // add the current marker to the map
                    counter += 1
                }
            }
        }
    }

    private func containsTitle(for theMarkers: [GMSMarker], name query: String) -> [Int]? {
        let markerTitles:[String] = theMarkers.map {$0.title!}
        let matches = markerTitles.enumerated().filter { $0.element.contains(query) }.map{$0.offset}
        if matches.isEmpty {
            return nil
        } else {
            return matches
        }
    }


}

/*
extension MapViewController: CLLocationManagerDelegate
{
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        switch status
        {
        case .authorizedAlways:
            print("Location AuthorizedAlways")
            mapView.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            print("Location AuthorizedWhenInUse")
            mapView.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
            
        case .denied:
            print("Location Denied")
            mapView.isMyLocationEnabled = false
            locationManager.stopUpdatingLocation()
            
        case .notDetermined:
            print("Location NotDetermined")
            mapView.isMyLocationEnabled = false
            locationManager.stopUpdatingLocation()
            
        case .restricted:
            print("Location Restricted")
            mapView.isMyLocationEnabled = false
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if locations.count > 0
        {
            mapView.camera = GMSCameraPosition.camera(withTarget: (locations.last?.coordinate)!, zoom: 10.0)
            mapView.settings.myLocationButton = true
        }
    }
}
*/









