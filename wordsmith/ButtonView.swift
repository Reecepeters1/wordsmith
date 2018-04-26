//
//  ButtonView.swift
//  wordsmith
//
//  Created by PETERS, REECE on 4/16/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

protocol IndexDelegate: NSObjectProtocol {
    func doSwipeUp()
    func doSwipeDown()
    func doSwipeLeft()
    func doSwipeRight()
}

class ButtonView: UIView {
    
    var hit: CGPoint = CGPoint()
    
    weak var delegate: IndexDelegate?
    
    override func draw(_ rect: CGRect) {
        
        let path1 = UIBezierPath(rect: rect)
        #colorLiteral(red: 0.7484021976, green: 0.867255727, blue: 0.9230052348, alpha: 1).setFill()
        path1.fill()
        
        let path = UIBezierPath(ovalIn: rect)
        UIColor.black.setFill()
        path.fill()
        
        let aPath = UIBezierPath()
        
        aPath.lineWidth = 3
        
        aPath.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        
        aPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        aPath.close()

        #colorLiteral(red: 0.7484021976, green: 0.867255727, blue: 0.9230052348, alpha: 1).set()
        aPath.stroke()
        
        aPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        
        aPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        
        aPath.close()
        
        aPath.stroke()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        hit = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        hit = touch.location(in: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let curve1 = hit.x
        let curve2 = -(hit.x) + bounds.height
        
        if (hit.y < curve1 && hit.y < curve2) {
            swipeUp()
        }
        
        if (hit.y >= curve1 && hit.y < curve2) {
            swipeLeft()
        }
        
        if (hit.y < curve1 && hit.y >= curve2) {
            swipeRight()
        }
        
        if (hit.y >= curve1 && hit.y >= curve2) {
            swipeDown()
        }
    }
    
    func swipeUp() {
        delegate?.doSwipeUp()
    }
    
    func swipeRight() {
        delegate?.doSwipeRight()
    }
    
    func swipeLeft() {
        delegate?.doSwipeLeft()
    }
    
    func swipeDown() {
        delegate?.doSwipeDown()
    }
    
}
