//
//  MapViewController.swift
//  LAMagazineLocationMapper
//
//  Created by Finn on 4/13/17.
//  Copyright © 2017 Finn. All rights reserved.
//  For info on centering the map on the user, see: http://www.seemuapps.com/swift-google-maps-sdk-integration-with-current-location-and-markers

import UIKit
import GoogleMaps
import os.log

class MapViewController: UIViewController, CLLocationManagerDelegate, centerCameraHereDelegate {
    
    //MARK: Properties
    // an array of the items
    var items = [Item]()
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    var markers = [GMSMarker]()
    // default location for where the camera should start
    var startCamera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 34.1,
                                                                  longitude: -118.3,
                                                                  zoom: 11)
    
    var selectedItemLocation:Int?
    // when the user selects an eatery to center on, this stores the item number so that all the eateries with that item can have their pin color changed
    // required to conform to the centerCameraHereDelegate protocol
    // default value is default to center on the user
    var centerOnLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Use this function because it is called every time the view appears, not just when it is loaded like viewDidLoad
        
        super.viewWillAppear(animated)
    
        // load the items list from memory or, failing that, the default items
        safeLoadItems()
        
        var accumlateTrues: Int = 0
        for i in 0..<100 {
            if items[i].disableMarkers {
                accumlateTrues += 1
            }
        }
        
        // create the map view property
        mapView = GMSMapView(frame: .zero)
        // Allow tracking of the user
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        // put the markers on the map
        mapMarkers(for: mapView)
        
        if centerOnLocation {
            // center on the desired location
            mapView.camera = startCamera // update the camera position to that set by the centerHere method
        } else {
            // Find the user location
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
        // generate the map view
        self.view = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Center camera on user method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        //let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView.camera = camera // update the camera position only
        
        //self.view = mapView  // show the map
        
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: Center camera on tapped location method
    
    func centerHere(for item: Int) {
        
        selectedItemLocation = item  // save the number of the selected item's location
        let theItem = items[item]
        var distance: Double = 100 // pick a huge distance to start
        let userLocation = locationManager.location // find the user's last known location
        var closestLocation: Int? = nil
        
        // only allowed to center on non-mobile locations with coordinates
        if (theItem.coords != nil && !theItem.isMobile) {
            for jj in 0..<theItem.coords!.count {
                let tempCoords = theItem.coords![jj].components(separatedBy: ",")
                let tempDistance = sqrt(pow(Double(tempCoords[0])! - userLocation!.coordinate.latitude,2) + pow(Double(tempCoords[1])! - userLocation!.coordinate.longitude,2))
                if tempDistance <= distance {
                    distance = tempDistance
                    closestLocation = jj
                }
            }
            
            if (closestLocation != nil) { // check that closest location is not nil
                let coordinates = items[item].coords![closestLocation!].components(separatedBy: ",")
                startCamera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!), zoom: 16)
            }
            
            self.centerOnLocation = true
        }
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
        // set the text of the button to return to the map view from the table view to "Map"
        // See: http://stackoverflow.com/questions/27713747/execute-action-when-back-bar-button-of-uinavigationcontroller-is-pressed for another option that includes functions
        let backItem = UIBarButtonItem()
        backItem.title = "Map"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        // set this View Controller as the delegate for the camera centering prototcol
        let destVC:ItemTableViewController = segue.destination as! ItemTableViewController
        destVC.centerCameraDelegate = self
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
            if items[ii].disableMarkers {
                continue  // skip this marker maker if the disableMarkers flag is true
            }
            // check to see if the title already exists in the array of markers
            if let theIndexes: [Int] = containsTitle(for: markers, name: items[ii].name) {
                // if so, add the item number and name to the snippet for those items
                for jj in theIndexes {
                    let oldSnippet = markers[jj].snippet!
                    markers[jj].snippet = oldSnippet + "\n" + "\(items[ii].number): \(items[ii].item)"
                    if !items[ii].visited {
                        // if the new item hasn't been tried (visited = false), set the pin red
                        markers[jj].icon = GMSMarker.markerImage(with: .red)
                    }
                    
                }
            } else {  // add the items to the GMSMarker list
                // testing in playground tells me the following line should fail when the
                // items[ii-1].coords.count is 1, but it appears to be working
                if (items[ii].coords != nil && !items[ii].isMobile) { // check if the item's coordinates exist
                    let theItem = items[ii]
                    for jj in 0..<theItem.coords!.count {
                        let tempMarker = GMSMarker()
                        let coordinates = theItem.coords![jj].components(separatedBy: ",")
                        tempMarker.position = CLLocationCoordinate2D(latitude: Double(coordinates[0])!, longitude: Double(coordinates[1])!)
                        // title the marker with the item number and the name
                        tempMarker.title = theItem.name
                        // add the name of the item to the marker when tapped
                        tempMarker.snippet = "\(theItem.number): \(theItem.item)"
                        
                        if theItem.visited {
                            // if the place has been visited, set the marker to green
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
        
        // find the markers that are for locations that the user selected
        if selectedItemLocation != nil {
            let matches = containsTitle(for: markers, name: items[selectedItemLocation!].name)
            for kk in matches! {  // force unwrap is ok because there must be a selected item
                markers[kk].icon = GMSMarker.markerImage(with: .magenta)
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









