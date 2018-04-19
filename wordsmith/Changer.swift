//
//  Changer.swift
//  tester
//
//  Created by PETERS, REECE on 2/8/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable

class Changer: UIButton {
    
    @IBInspectable var pressed: Bool = false
    @IBInspectable var color: UIColor = UIColor.black
    @IBInspectable var border: UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        color.setFill()
        path.fill()
        layer.borderWidth = 1
        layer.borderColor = border.cgColor
    }
    
    func setPressed(press: Bool) {
        pressed = press
        return
    }
    
    func setColor(col: UIColor) {
        color = col
    }
    
    func getColor() -> UIColor {
        return color
    }
    
    func changePress() {
        if pressed {
            border = UIColor.gray
        } else {
            border = UIColor.black
        }
        setNeedsDisplay()
    }
}
