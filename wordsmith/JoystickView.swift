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
    var hit: CGPoint = CGPoint()
    
    required init?(coder aDecoder: NSCoder) {
        isDrawing = false
        
        super.init(coder: aDecoder)
        
        let path: UIBezierPath = UIBezierPath(ovalIn: self.frame)
        layer1.frame = self.frame
        layer1.path = path.cgPath
        layer1.fillColor = UIColor.gray.cgColor
        
        stick.frame = CGRect(origin: CGPoint(x: self.center.x - self.frame.midX, y: self.center.y - self.frame.midY), size: CGSize(width: self.frame.midX / 2, height: self.frame.midY / 2))
        let path1: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: stick.frame.midX, y: stick.frame.midY), radius: self.bounds.midX / 2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        stick.path = path1.cgPath
        stick.fillColor = UIColor.black.cgColor
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        
        stick.borderWidth = 3
        stick.borderColor = UIColor.red.cgColor
        
        layer1.borderWidth = 4
        layer1.borderColor = UIColor.blue.cgColor
        
        self.layer.addSublayer(layer1)
        self.layer.addSublayer(stick)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = true
        guard let touch = touches.first else { return }
        hit = touch.location(in: self)
        if stick.frame.contains(hit) {
            stick.frame = CGRect(origin: CGPoint(x: hit.x - stick.frame.maxX + stick.bounds.midX, y: hit.y - stick.bounds.maxY + stick.bounds.midY), size: CGSize(width: self.bounds.midX, height: self.bounds.midY))
        }
        else
        {
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        isDrawing = false
        let xCurve = hit.y
        let yCurve = -(hit.x) + self.frame.maxY
        if (hit.x >= xCurve && hit.x > yCurve)
        {
            doSwipeUp()
        }
        if (hit.x < xCurve && hit.x > yCurve)
        {
            doSwipeLeft()
        }
        if (hit.x >= xCurve && hit.x <= yCurve)
        {
            doSwipeRight()
        }
        if (hit.x < xCurve && hit.x <= yCurve)
        {
            doSwipeDown()
        }
        hit = CGPoint(x: self.center.x - self.frame.midX, y: self.center.y - self.frame.midY)
        stick.frame = CGRect(origin: CGPoint(x: hit.x - stick.bounds.maxX + stick.bounds.midX, y: hit.y - stick.bounds.maxY + stick.bounds.midY), size: CGSize(width: self.bounds.midX, height: self.bounds.midY))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        guard let touch = touches.first else { return }
        hit = touch.location(in: self)
        stick.frame = CGRect(origin: CGPoint(x: hit.x - stick.bounds.maxX + stick.bounds.midX, y: hit.y - stick.bounds.maxY + stick.bounds.midY), size: CGSize(width: self.bounds.midX, height: self.bounds.midY))
    }
    
    func doSwipeUp() {
        print(hit)
    }
    
    func doSwipeLeft() {
        print(hit)
    }
    
    func doSwipeRight() {
        print(hit)
    }
    
    func doSwipeDown() {
        print(hit)
    }
}
