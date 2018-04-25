//
//  Debate.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 12/8/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import os.log

public class Debate: NSObject {
    
    enum Ballot {
        
        enum WinLoss {
            case win
            case loss
        }
        
        //The first int is judges for this team, the second int is judges against this team.
        case decision(WinLoss, Int, Int)

    }
    
    var ballot:Ballot = .decision(.win, 0, 0)
    var positions:[Flow] = []
    var roundNumber:Int? //always check for nil when acessing this value
    var otherTeam:String
    var expirationDate:Date?
    var winLoss:Bool? //always check for nil when acessing this value
    var judgeName:String
    var judgeNumber:Int = 1
    var dateCreated:Date?
    var tournament: String
    // this value is used init the first flow in a debate should be completely empty tho
    var firstflow = Flow()
    
    //sets all of the fields, exept for the date fields
    init(roundNumber: Int, otherTeam: String, winLoss: Bool, judgeName: String, judgeNumber: Int, tournament: String) {
        
        self.roundNumber = roundNumber
        self.winLoss = winLoss
        self.otherTeam = otherTeam
        self.judgeName = judgeName
        self.tournament = tournament
        self.positions.append(firstflow)
        self.judgeNumber = judgeNumber
        //set date created to current date
        //set expiration date to 1 month later
        
        super.init()
    }
    
    init(roundNumber: Int?, otherTeam: String?, winLoss: Bool?, judgeName: String?, judgeNumber: Int, tournament: String?) {
        
        self.judgeNumber = judgeNumber
        self.roundNumber = roundNumber
        self.winLoss = winLoss
        self.otherTeam = otherTeam ?? " "
        self.judgeName = judgeName ?? " "
        self.tournament = tournament ?? " "
        self.positions.append(firstflow)
        super.init()
        
    }
    
    func addflow(){
        let temp = Flow()
        positions.append(temp)
    }
    
    
    

    
}
