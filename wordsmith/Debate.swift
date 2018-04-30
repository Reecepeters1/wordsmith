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
        
        var winLoss: Ballot.WinLoss?
        var judgesFor:Int
        var judgesAgainst:Int
        var judgesTotal:Int
        
        init() {
            winLoss = nil
            judgesFor = 0
            judgesAgainst = 0
            judgesTotal = 0
        }

    }
    
    struct Round {
        var isElim: Bool
        var elim: String?
        var number: Int?
        
        init() {
            isElim = false
            elim = nil
            number = nil
        }
    }
    
    var ballot:Ballot
    var round:Round
    var positions:[Flow] = []
    var otherTeam:String
    var expirationDate:Date?
    var judgeName:String
    var dateCreated:Date?
    var tournament: String
    // this value is used init the first flow in a debate should be completely empty tho
    var firstflow = Flow()
    
    //sets all of the fields, exept for the date fields
    init(round: Debate.Round, otherTeam: String, ballot: Debate.Ballot, judgeName: String, tournament: String) {
        
        self.ballot = ballot
        self.round = round
        self.otherTeam = otherTeam
        self.judgeName = judgeName
        self.tournament = tournament
        self.positions.append(firstflow)
        //set date created to current date
        //set expiration date to 1 month later
        
        super.init()
    }
    
    init(ballot: Ballot?, round: Round?, otherTeam: String?, judgeName: String?, tournament: String?) {
        
        self.ballot = ballot ?? Ballot()
        self.round = round ?? Round()
        self.otherTeam = otherTeam ?? "Default"
        self.judgeName = judgeName ?? "Default"
        self.tournament = tournament ?? "Default"
        self.positions.append(firstflow)
        super.init()
        
    }
    
    func getWinLoss() -> String {
        
        let temp = ballot
        var winString:String
        
        if (temp.winLoss == nil) {
            return "No Winner Posted"
        } else if (temp.winLoss == .loss){
            winString = "Loss"
        } else {
            winString = "Win"
        }
        
        if (temp.judgesTotal == 1) {
            return winString
        } else {
            winString = winString + "\(temp.judgesFor) Judges for, " + "\(temp.judgesAgainst) Judges against"
        }
        
        return winString
       
    }
    
    func getRound() -> String {
        if (round.isElim) {
            return round.elim ?? "Unknown Round Type"
        } else {
            return "\(round.number ?? 0)"
        }
    }
    
    func addflow(){
        let temp = Flow()
        positions.append(temp)
    }
    
    
    

    
}
