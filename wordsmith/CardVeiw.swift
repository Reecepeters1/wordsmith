//
//  CollectionViewCell.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class CardView: UICollectionViewCell {
    
    var color: UIColor
    var strokeWidth: Int
    var path: UIBezierPath
    var startPoint: CGPoint
    var isDrawing: Bool
    var width: Int
    var length: Int
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        <#code#>
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    func storeCard(card: Card){
        //Text that stores card
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
