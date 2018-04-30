//
//  CollectionViewCell.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class CardView: UICollectionViewCell {
    @IBOutlet var cardimage: UIImageView!
    let storedCard:Card
    
    init?(draw: [CAShapeLayer],coder aDecoder: NSCoder) {
        self.storedCard = Card(draw: draw)
        super.init(coder: aDecoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.storedCard = Card()
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    
    
    
    
    //TODO Way to store location of a Card initialized elsewhere
    
    
    
    var isEndOfSpeech = false
    
    func isItEndOfSpeech() -> Bool{
        return isEndOfSpeech
    }
    func endspeech() -> Void{
        isEndOfSpeech = true
    }
    func notendspeech() -> Void{
        isEndOfSpeech = false
    }
    func displayContent(image: UIImage){
        cardimage.image = image
    }
    
    func showcard(card: Card){
        //main methods to be used for showing card in the cardView
    }
    
    func setColor(color: UIColor) {
        //Sets brush color
    }
    
    func setBrushWidth(width: Int) {
        //Sets brush width
    }
}

