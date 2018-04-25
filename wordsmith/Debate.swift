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
    
    struct Ballot {
        
        enum WinLoss {
            case win
            case loss
        }
        
        //The first int is judges for this team, the second int is judges against this team.
        var decision:( Ballot.WinLoss, Int, Int)

    }
    
    struct round {
        var isElim: Bool
        var elim: String?
        var number: Int?
    }
    
    var ballot:Ballot = Ballot(decision: (.win, 0, 0))
    
    var positions:[Flow] = []
    
    var roundNumber:round
    
    var otherTeam:String
    var expirationDate:Date?

    var judgeName:String
    var judgeNumber:Int = 1
    var dateCreated:Date?
    var tournament: String
    // this value is used init the first flow in a debate should be completely empty tho
    var firstflow = Flow()
    
    //sets all of the fields, exept for the date fields
    init(roundNumber: Debate.round, otherTeam: String, ballot: Debate.Ballot, judgeName: String, judgeNumber: Int, tournament: String) {
        
        self.roundNumber = roundNumber
        self.ballot = ballot
        self.otherTeam = otherTeam
        self.judgeName = judgeName
        self.tournament = tournament
        self.positions.append(firstflow)
        self.judgeNumber = judgeNumber
        //set date created to current date
        //set expiration date to 1 month later
        
        super.init()
    }
    
    init(roundNumber: Debate.round, otherTeam: String?, ballot: Debate.Ballot, judgeName: String?, judgeNumber: Int, tournament: String?) {
        
        self.judgeNumber = judgeNumber
        self.roundNumber = roundNumber
        self.ballot = ballot
        self.otherTeam = otherTeam ?? " "
        self.judgeName = judgeName ?? " "
        self.tournament = tournament ?? " "
        self.positions.append(firstflow)
        super.init()
        
    }
    
    func getWinLoss() -> String {
        let temp = ballot
        let judgesFor = temp.decision.1
        let judgesAgainst = temp.decision.2
        let myWinloss = temp.decision.0
        
        var myString: String
        if (myWinloss == .win) {
            myString = "Win"
        } else {
            myString = "false"
        }
        
        return "\(myString + " " + String(judgesFor) + ":" + String(judgesAgainst))"
    }
    
    func addflow(){
        let temp = Flow()
        positions.append(temp)
    }
    
    
    

    
}
