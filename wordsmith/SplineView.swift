//
//  CardView.swift
//  tester
//
//  Created by PETERS, REECE on 1/18/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class SplineView: UIView {
    
    private var color: UIColor
    private var strokeWidth: CGFloat
    private var isDrawing: Bool
    private var path: UIBezierPath
    private var drawLayer: CAShapeLayer
    private var storeLayer: [CAShapeLayer]
    private var interpolationPoints: [CGPoint]
    private var index: Int
    
    required init?(coder aDecoder: NSCoder) {
        
        index = 0
        color = UIColor.black
        strokeWidth = 3
        isDrawing = false
        path = UIBezierPath()
        drawLayer = CAShapeLayer()
        storeLayer = [CAShapeLayer]()
        interpolationPoints = [CGPoint]()
        
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
        storeLayer.append(CAShapeLayer())
        
        layer.addSublayer(storeLayer[index])
        layer.addSublayer(drawLayer)
        
        drawLayer.fillColor = nil
        drawLayer.strokeColor = color.cgColor
        drawLayer.lineWidth = strokeWidth
        drawLayer.lineCap = kCALineCapRound
        
        storeLayer[index].fillColor = nil
        storeLayer[index].strokeColor = color.cgColor
        storeLayer[index].lineWidth = strokeWidth
        storeLayer[index].lineCap = kCALineCapRound
        
        storeLayer[index].path = CGMutablePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = true
        guard let touch = touches.first else { return }
        interpolationPoints.append(touch.location(in: self))
        path = UIBezierPath(arcCenter: touch.location(in: self), radius: strokeWidth / 30, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        
        let tempPath: CGMutablePath = (storeLayer[index].path?.mutableCopy())!
        
        tempPath.addPath(path.cgPath)
        
        storeLayer[index].path = tempPath
        
        path.removeAllPoints()
        
        interpolationPoints.removeAll()
        
        drawLayer.path = path.cgPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let touch = touches.first else { return }
        path.removeAllPoints()
        guard let coalesced = event?.coalescedTouches(for: touch) else { return }
        coalesced.forEach {
            interpolationPoints.append($0.location(in: self))
        }
        path.interpolatePointsWithHermite(interpolationPoints)
        drawLayer.path = path.cgPath
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        path.removeAllPoints()
    }
    
    func setPath(fore: UIColor, store: UIColor, width: CGFloat) {
        color = fore
        strokeWidth = width
        drawLayer.strokeColor = fore.cgColor
        drawLayer.lineWidth = strokeWidth
        index += 1
        self.newPath()
    }
    
    func clearDraw() {
        path.removeAllPoints()
        drawLayer.path = path.cgPath
        drawLayer.lineWidth = strokeWidth
        index = 0
        
        for i in storeLayer {
            i.removeFromSuperlayer()
        }
        
        storeLayer.removeAll()
        self.newPath()
    }
    
    func getForeColor() -> UIColor {
        return color
    }
    
    func newPath() {
        storeLayer.append(CAShapeLayer())
        storeLayer[index].fillColor = nil
        storeLayer[index].strokeColor = color.cgColor
        storeLayer[index].lineWidth = strokeWidth
        storeLayer[index].lineCap = kCALineCapRound
        storeLayer[index].path = CGMutablePath()
        layer.addSublayer(storeLayer[index])
        drawLayer.removeFromSuperlayer()
        layer.addSublayer(drawLayer)
    }
    
    func getCard() -> Card {
        return Card(draw: storeLayer)
    }
    
    func setCard(tempCard: Card) {
        storeLayer = tempCard.getVeiw()
    }
}
