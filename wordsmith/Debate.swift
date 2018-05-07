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
    //This enum tracks what side this team is on
    enum Side {
        case aff
        case neg
    }
    //This struct is used to model the ballot at the end of the round.
    struct Ballot {
        
        enum WinLoss {
            case win
            case loss
            case tie
            case didNotDisclose
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
    
    //This struct records the tournaments round inforamtion, specifical number or elim type.
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
    
    struct Judge {
        enum Vote {
            case forUs
            case against
            case didNotDisclose
            case inProgress
        }
        
        var name: String
        var vote: Vote?
    }
    
    var side: Side
    var ballot:Ballot
    var round:Round
    var positions:[Flow] = []
    var otherTeam:String
    var expirationDate:Date?
    var judgeNames:[Judge] = []
    var dateCreated:Date?
    var tournament: String
    // this value is used init the first flow in a debate should be completely empty tho
    var firstflow = Flow()
    
    //sets all of the fields, exept for the date fields
    init(round: Debate.Round, otherTeam: String, ballot: Debate.Ballot, judgeName: [String], tournament: String, side: Debate.Side) {
        
        self.ballot = ballot
        self.round = round
        self.otherTeam = otherTeam
        self.side = side
        for j in judgeName {
            self.judgeNames.append(Debate.Judge(name: j, vote: nil))
        }
        
        self.tournament = tournament
        self.positions.append(firstflow)
        //set date created to current date
        //set expiration date to 1 month later
        
        super.init()
    }
    
    init(ballot: Ballot?, round: Round?, otherTeam: String?, judgeName: [String?], tournament: String?, side: Debate.Side?) {
        
        self.ballot = ballot ?? Ballot()
        self.round = round ?? Round()
        self.otherTeam = otherTeam ?? "Default"
        let temp:[String]
        
        if (!judgeName.isEmpty) {
            temp = judgeName.map{ $0 ?? ""}
            for judge in temp {
                if judge != "" {
                    self.judgeNames.append(Debate.Judge(name: judge, vote: nil))
                }
            }
        } else {
            self.judgeNames.append(Debate.Judge(name: "Default", vote: nil))
        }
        
        self.tournament = tournament ?? "Default"
        self.positions.append(firstflow)
        self.side = side ?? .aff
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
    
    func getSide() -> String {
        if (side == .aff) {
            return "Affirmative"
        } else if (side == .neg){
            return "Negative"
        } else {
            return "Did not Disclose"
        }
    }
    
    func addflow(){
        let temp = Flow()
        positions.append(temp)
    }
    
    
    

    
}
