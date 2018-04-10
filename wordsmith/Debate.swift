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
    
    var positions:[Flow]?
    var title:String
    var roundNumber:Int? //always check for nil when acessing this value
    var otherTeam:String
    var expirationDate:Date?
    var winLoss:Bool? //always check for nil when acessing this value
    var judgeName:String
    var dateCreated:Date?
    var tournament: String
    
    //sets all of the fields, exept for the date fields
    init(title: String, roundNumber: Int, otherTeam: String, winLoss: Bool, judgeName: String, tournament: String) {
        
        self.title = title
        self.roundNumber = roundNumber
        self.winLoss = winLoss
        self.otherTeam = otherTeam
        self.judgeName = judgeName
        self.tournament = tournament
        //set date created to current date
        //set expiration date to 1 month later
        
        super.init()
    }
    
    init(title: String?, roundNumber: Int?, otherTeam: String?, winLoss: Bool?, judgeName: String?, tournament: String?) {
        
        self.title = title ?? " "
        self.roundNumber = roundNumber
        self.winLoss = winLoss
        self.otherTeam = otherTeam ?? " "
        self.judgeName = judgeName ?? " "
        self.tournament = tournament ?? " "
        
        super.init()
        
    }
    func addflow(){
        
        let temp = Flow()
        
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
