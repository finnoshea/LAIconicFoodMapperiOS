//
//  Item.swift
//  LAMagazineLocationMapper
//
//  Created by Finn on 4/13/17.
//  Copyright © 2017 Finn. All rights reserved.
//
// You cannot archive structures without more work, see here:
// https://blog.vishalvshekkar.com/archiving-and-unarchiving-swift-structure-instances-revisited-7ef6ab447095
// Store the coordinates as a string: "34.059768,-118.237035"

import UIKit
import os.log

class Item: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var number: Int
    var item: String
    var visited: Bool
    var coords: [String]
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("locations")

    //MARK: Types
    
    struct PropertyKey {
        // This is a list of keys you will use in your encoding/decoding scheme
        // Like keys in a python dictionary
        static let name = "name"
        static let number = "number"
        static let item = "item"
        static let visited = "visited"
        static let coords = "coords"
    }
    
    /* - No longer useful
    struct Coordinate {
        let latitude: Double
        let longitude: Double
    }
    */
    
    //MARK: Initialization
    
    init(name: String, number: Int, item: String, visited: Bool, coords: [String]) {
       
        // Initialize stored properties
        self.name = name
        self.number = number
        self.item = item
        self.visited = visited
        self.coords = coords
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: PropertyKey.name)
        aCoder.encode(self.number, forKey: PropertyKey.number)
        aCoder.encode(self.item, forKey: PropertyKey.item)
        aCoder.encode(self.visited, forKey: PropertyKey.visited)
        aCoder.encode(self.coords, forKey: PropertyKey.coords)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // guard the unwrapping of the strings
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a location.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let item = aDecoder.decodeObject(forKey: PropertyKey.item) as? String else {
            os_log("Unable to decode the item for a location.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let coords = aDecoder.decodeObject(forKey: PropertyKey.coords) as? [String] else {
            os_log("Unable to decode the coords for a location.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Decode the other properties with included unwrappers
        let number = aDecoder.decodeInteger(forKey: PropertyKey.number)
        let visited = aDecoder.decodeBool(forKey: PropertyKey.visited)
        
        // must call a designated initializer
        self.init(name: name, number: number, item: item, visited: visited, coords: coords)
    }
}




















