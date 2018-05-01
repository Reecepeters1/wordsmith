//
//  Flow.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit

class Flow{
    
    var Speeches: [Speech] = []
    
    init() {
    }
    
    func returnflow() -> [Speech]{
        return Speeches
    }
    //add a speech
    func addSpeech() -> Void
    {
        let placeholder: [CardView] = []
        let newspeech = Speech(array: placeholder)
        Speeches.append(newspeech)
    }
    
    //remove a speech at the specified index
    func removeSpeech(Speech: Int) -> Void{
        //TODO make error handling when going out of bounds
        Speeches.remove(at: Speech)
    }
    
    //remove the most recent speech
    func removeSpeech()
    {
        if Speeches.count == 0{
            return
                print("function has not run flow is empty")
        }
        //TODO make error handling when going out of bounds
        Speeches.remove(at: Speeches.count - 1)
    }
    
    //gets a card a the specific index
    func getcard(Speech: Int, Index: Int) -> CardView{
        //TODO make error handling when going out of bounds
        return Speeches[Speech].getcard(Index: Index)
    }
    
    //returns longest column this is to makes sure that when we do the calculations for card sizing that they are sized to the largest column so they all fit on the screen
    func longestcolumn() -> Int{
        //counter
        var biggestsize = 0
        if Speeches.count == 0{
            return 1
        }
        //for loop
        for i in 0..<Speeches.count{
            if Speeches[i].getcount() > biggestsize{
                biggestsize = Speeches[i].getcount()
            }
        }
        
        //we add + 1 so we can have space to add creating speech/cards buttons later on
        return biggestsize + 1
    }
    
}


