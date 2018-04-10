//
//  JoystickView.swift
//  wordsmith
//
//  Created by PETERS, REECE on 4/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class JoystickView: UIView {
    
    let layer1: CAShapeLayer = CAShapeLayer()
    let stick: CAShapeLayer = CAShapeLayer()
    var isDrawing: Bool
    
    required init?(coder aDecoder: NSCoder) {
        isDrawing = false
        
        super.init(coder: aDecoder)
        
        let path: UIBezierPath = UIBezierPath(ovalIn: self.layer.frame)
        let layer1: CAShapeLayer = CAShapeLayer()
        layer1.frame = self.frame
        layer1.path = path.cgPath
        layer1.fillColor = UIColor.gray.cgColor
        
        stick.frame = CGRect(origin: CGPoint(x: self.center.x - self.frame.midX, y: self.center.y - self.frame.midY), size: CGSize(width: self.frame.midX / 2, height: self.frame.midY / 2))
        let path1: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: stick.frame.midX, y: stick.frame.midY), radius: self.bounds.midX / 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        stick.path = path1.cgPath
        stick.fillColor = UIColor.black.cgColor
        
        self.layer.addSublayer(layer1)
        self.layer.addSublayer(stick)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = true
        guard let touch = touches.first else { return }
        let hit = touch.location(in: self)
        if stick.frame.contains(hit) {
            stick.frame = CGRect(origin: CGPoint(x: hit.x - stick.bounds.midX, y: hit.y - stick.bounds.midY), size: CGSize(width: self.bounds.midX, height: self.bounds.midY))
        }
        else
        {
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    
    
    
}
