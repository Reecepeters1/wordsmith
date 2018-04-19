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
    
    var responses:[Int] = []
    var drawing: [CAShapeLayer]
    var speech:Int = -1
    var positionInSpeech:Int = -1
    var isAResponse = false
    var isFlagged = false
    var image: UIImage = UIImage()
    
    init(draw: [CAShapeLayer]) {
        drawing = draw
        image = createPDFimage()
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
        //will be used for creating pdf of all aggregated images
        return #imageLiteral(resourceName: "startImage")
    }
    
    func getFlagged() -> Bool {
        return isFlagged
    }
    
    func setFlagged(isFlag: Bool) {
        isFlagged = isFlag
        return
    }
    
}
