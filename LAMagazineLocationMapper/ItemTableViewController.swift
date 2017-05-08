//
//  ItemTableViewController.swift
//  LAMagazineLocationMapper
//
//  Created by Finn on 4/14/17.
//  Copyright © 2017 Finn. All rights reserved.
//

import UIKit
import os.log

protocol centerCameraHereDelegate {
    
    var centerOnLocation: Bool { get set }
    // a flag that is true when the map should center on a location rather than the user
    // default value should be set to false to center on the user at first load
    
    func centerHere(for item: Int)
    // centerHere is a method that takes an item number and returns the nearest location with that item
}

class ItemTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var items = [Item]()
    @IBOutlet var theTableView: UITableView!
    var centerCameraDelegate: centerCameraHereDelegate? = nil
    
    //MARK: Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTableView.dataSource = self
        
        // use a helper function to load the map locations
        //safeLoadItems()
        items = initializeItemData()
        
        // set the nav bar title to the user's number of items had out of 100
        navigationItem.title = "\(items.map{$0.visited}.filter{$0}.count) / 100"

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (centerCameraDelegate != nil) {
            centerCameraDelegate?.centerOnLocation = false
            // set the centerOnLocation variable to false, so that the map view centers on the user  by default
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source information

    override func numberOfSections(in tableView: UITableView) -> Int {
        // this is a simple table, use only one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of elements in the locations property
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetches the appropriate location for the data source layout.
        let item = items[indexPath.row]
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        // downcast the cell from superclass UITableViewCell to subclass ItemTableViewCell safely
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
            
        cell.locationLabel.text = item.name
        cell.numberLabel.text = String(item.number)
        cell.visitSwitch.isOn = item.visited
        cell.itemLabel.text = parseItemName(item.item)
        cell.isMobile = item.isMobile
        cell.disableMarkers = item.disableMarkers
        cell.chain = item.chain
        cell.delegate = self
        
        
        if cell.isMobile || cell.chain || cell.disableMarkers {
            if cell.isMobile { // mobile eateries are shown with a food truck
                cell.locationLabel.backgroundColor = UIColor(patternImage: UIImage(named: "FoodTruck")!)
            }
            if cell.chain {
                cell.locationLabel.backgroundColor = UIColor(patternImage: UIImage(named: "Chain")!)
            }
            if cell.disableMarkers {
                cell.locationLabel.backgroundColor = UIColor(patternImage: UIImage(named: "CrossOut")!)
            }
        } else {
            cell.locationLabel.backgroundColor = nil
        }
        
        return cell

    }
 
    //MARK: Private Methods
    
    // helper function to add some data to work with while building this app
    private func loadSampleItems() {
        items += initializeItemData()
    }
    
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

    private func parseItemName(_ itemString: String) -> String {
        // this does nothing at the moment
        return itemString
    }
    
    private func saveItems() {
        _ = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
        
        /*
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Items successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save items.", log: OSLog.default, type: .error)
        }
         */
    }
    
    private func loadItems() -> [Item]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }

    
}

// MARK: Extensions - used so the main class doesn't have a ton of adopt protocols up top
extension ItemTableViewController: ButtonDelegate {
    // See http://stackoverflow.com/questions/39566065/uiswitch-in-accessory-view-of-a-tableviewcell-passing-a-parameter-with-the-sele
    
    func didFlipVisitSwitch(for cell: ItemTableViewCell, value: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            items[indexPath.row].visited = value
            // set the nav bar title to the user's number of items had out of 100
            navigationItem.title = "\(items.map{$0.visited}.filter{$0}.count) / 100"
            /*
            if value {
                os_log("Visit switch set to ON.", log: OSLog.default, type: .error)
            } else {
                os_log("Visit switch set to OFF.", log: OSLog.default, type: .error)
            }
             */
        }
    }
    
    func didTapLocationLabel(for cell: ItemTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if !items[indexPath.row].isMobile { // only go through with tap function if the eatery is NOT mobile
                if !items[indexPath.row].disableMarkers { // check that markers are enabled ... xor would be nice here
                    if !items[indexPath.row].chain { // check that the location is not a chain ... again xor
                        if let cameraDelegate = centerCameraDelegate {
                            cameraDelegate.centerHere(for: indexPath.row)
                            self.navigationController!.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func didSwipeLocationLabelRight(for cell: ItemTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if items[indexPath.row].isMobile || items[indexPath.row].chain {
                // do nothing, we don't want swiping affecting these types
            } else {
                // flip the disableMarkers flag when the location label is swiped
                items[indexPath.row].disableMarkers = true
                // set the background image to the CrossOut immediately
                cell.locationLabel.backgroundColor = UIColor(patternImage: UIImage(named: "CrossOut")!)
            }
            
        }
    }
    
    func didSwipeLocationLabelLeft(for cell: ItemTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if items[indexPath.row].isMobile || items[indexPath.row].chain {
                // do nothing, we don't want swiping affecting these types
            } else {
                // flip the disableMarkers flag when the location label is swiped
                items[indexPath.row].disableMarkers = false
                // set the background image to nil immediately
                cell.locationLabel.backgroundColor = nil
            }
        }
    }
}

























