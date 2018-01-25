//
//  MainScreen.swift
//  wordsmith/Users/802781/Documents/wordsmith/wordsmith/MainScreen.swift
//
//  Created by KRUEGER, JOHN on 1/24/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import os.log

public class MainScreen: NSObject {
    
    var debates:[Debate] = []
    
    
    private func saveData () {
        Storage.myArray = debates
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Storage.myArray!, toFile: Storage.ArchiveUrl.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadData() -> Bool {
        let tempDebates = NSKeyedUnarchiver.unarchiveObject(withFile: Storage.ArchiveUrl.path)
        if (tempDebates != nil) {
            debates = tempDebates as! [Debate]
            return true
        }  else {
            return false
        }
    }
    
    
}
