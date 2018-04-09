//
//  Debate.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import os.log

class Debate: NSObject {
    
    var positions:[Flow] = []
    var title:String?
    var roundNumber:Int?
    var otherTeam:String?
    var expirationDate:Date?
    var winLoss:Bool?
    var judgeName:String?
    var dateCreated:Date?
    var tournament: String?
    
    //generic init
    override init() {
        super.init()
        otherTeam = Debate.randomString(length: 10)
    }
    
    init(title: String, roundNumber: Int, otherTeam: String, judgeName: String) {
        super.init()
        self.title = title
        self.roundNumber = roundNumber
        self.otherTeam = otherTeam
        self.judgeName = judgeName
    }
    func addflow(){
        let temp = Flow()
        positions.append(temp)
    }
    
    private static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    

    
}
