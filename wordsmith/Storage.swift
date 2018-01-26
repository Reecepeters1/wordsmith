//
//  Storage.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 1/24/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import os.log


public class Storage: NSObject, NSCoding {
    
    //This is the array of Debate objects that gets recalled, then pased to main menue.
    //Also the array that the main menu copies unto when it saves.
    static var myArray:[Debate]?
    
    //Static structure that lets us restore our data
    struct PropertyKey {
        static let name = "name"
    }
    
    //This is the location where the files are archived
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("wordsmith")
    
    init(array: [Debate]) {
        super.init()
        Storage.myArray = array
    }
    
    //takes a deconder, and uses magic to retrieve our data from the file system.
    required convenience public init?(coder aDecoder: NSCoder) {
        guard let ThisArray = aDecoder.decodeObject(forKey: PropertyKey.name) as? [Debate] else {
            os_log("Unable t Decode the name for a myArrayObject.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(array: ThisArray)

    }
    
    //uses magic to make an archive of data. I don't undertand how this work, but it does
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(Storage.myArray!, forKey: PropertyKey.name)
    }
}
