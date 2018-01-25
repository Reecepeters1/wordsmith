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
    
    static var myArray:[Debate]?
    
    
    struct PropertyKey {
        static let name = "name"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("wordsmith")
    
    init(array: [Debate]) {
        super.init()
        Storage.myArray = array
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        guard let ThisArray = aDecoder.decodeObject(forKey: PropertyKey.name) as? [Debate] else {
            os_log("Unable t Decode the name for a myArrayObject.", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(array: ThisArray)

    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(Storage.myArray!, forKey: PropertyKey.name)
    }
}
