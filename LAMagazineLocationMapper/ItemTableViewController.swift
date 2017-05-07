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
        // safeLoadItems()
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
            // set the centerOnLocation variable to false, so that the map view centers on the user
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

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ItemTableViewCell"
        // define the cell to be of the type defined in cellIdentifier
        // downcast the cell (from superclass UITableViewCell to subclass ItemTableViewCell) safely
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }
        
        // Fetches the appropriate location for the data source layout.
        let item = items[indexPath.row]
        
        cell.locationLabel.text = item.name
        cell.numberLabel.text = String(item.number)
        cell.visitSwitch.isOn = item.visited
        cell.itemLabel.text = parseItemName(item.item)
        cell.isMobile = item.isMobile
        cell.delegate = self
        
        return cell
    }

 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        print("Moving views!")
        if segue.identifier == "BackToMaps" {
            let destVC:MapViewController = segue.destination as! MapViewController
            destVC.centerOnLocation = false
            print("Reseting centerOnLocation to false.")
        }
        
    }
    */
 
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
            os_log("Items successfully loaded.", log: OSLog.default, type: .debug)
            if items.count < 100 {
                items.removeAll()
                items = initializeItemData()
                os_log("Saved list is incomplete, loading initial data.", log: OSLog.default, type: .debug)
            }
        }
        else {
            // Load the all the items on first load.
            items = initializeItemData()
            os_log("Items loaded from internal memory.", log: OSLog.default, type: .debug)
        }
    }

    private func parseItemName(_ itemString: String) -> String {
        // this does nothing at the moment
        return itemString
    }
    
    private func saveItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)

        if isSuccessfulSave {
            os_log("Items successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save items.", log: OSLog.default, type: .error)
        }
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
            
            if value {
                os_log("Visit switch set to ON.", log: OSLog.default, type: .error)
            } else {
                os_log("Visit switch set to OFF.", log: OSLog.default, type: .error)
            }
        }
        
    }
    
    func didTapLocationLabel(for cell: ItemTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if let cameraDelegate = centerCameraDelegate {
                cameraDelegate.centerHere(for: indexPath.row)
                self.navigationController!.popViewController(animated: true)
            }
            
        }
        
    }
    
}

























