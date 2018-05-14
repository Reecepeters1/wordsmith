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
    
    var holder: CardView = CardView(draw: [CAShapeLayer](), coder: NSCoder())!
    var responses: [Card] = []
    var responses: [CardView] = []
    var drawing: [CAShapeLayer]
    var speech:Int = -1
    var positionInSpeech:Int = -1
    var isAResponse = false
    var isFlagged = false
    var previousCard: Card? = nil
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
    
    func createPDFimage() -> UIImage {
        return #imageLiteral(resourceName: "startImage")
    }
    
    func getFlagged() -> Bool {
        return isFlagged
    }
    
    func setFlagged(isFlag: Bool) {
        isFlagged = isFlag
        return
    }
    
    func addAnswer(ans: CardView) {
        responses.append(ans)
    }
    
    func setImage(set: UIImage) {
        image = set
    }
    
    func setHolder(set: CardView) {
        holder = set
    }
    
    func hasResponses() -> Bool {
        if responses.count == 0
        {
            return false
        } else {
            return true
        }
    }
    
    func setHasResponses(hey: Bool) {
        isAResponse = hey
    }
}
