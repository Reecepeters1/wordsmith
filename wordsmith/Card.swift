//
//  Card.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore

class Card {
    
    var responses: [Card] = []
    var drawing: [CAShapeLayer]
    var speech:Int = -1
    var positionInSpeech:Int = -1
    var isAResponse = false
    var isFlagged = false
    var previousCard: Card?
    var image: UIImage = UIImage()
    
    init(draw: [CAShapeLayer], maybe: Card?) {
        drawing = draw
        previousCard = maybe
    }
    
    init(){
        drawing = []
    }
    
    func getanswers(){
        if isAResponse{
            //get cards
        }
        return
    }
    func getVeiw() -> [CAShapeLayer] {
        return drawing
    }
        
    func getFlagged() -> Bool {
        return isFlagged
    }
    
    func setFlagged(isFlag: Bool) {
        isFlagged = isFlag
        return
    }
    
    func addAnswer(ans: Card) {
        responses.append(ans)
    }
    
    func setImage(set: UIImage) {
        image = set
    }
}
