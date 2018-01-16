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
    var strokeWidth: CGFloat
    var path: UIBezierPath
    var startPoint: CGPoint
    var isDrawing: Bool
    
    override func layoutSubviews() {
        color = UIColor.black
        strokeWidth = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = true
        guard let touch = touches.first else { return }
        startPoint = touch.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        startPoint.x = -1
        startPoint.y = -1
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        
        path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: touchPoint)
        startPoint = touchPoint
        
        drawShapeLayer()
    }
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
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
