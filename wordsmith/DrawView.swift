//
//  DrawView.swift
//  wordsmith
//
//  Created by PETERS, REECE on 4/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class DrawView: UIViewController, IndexDelegate {
    
    var wid = CGFloat()
    
    var currentCard = MainMenuData.debates[MainMenuData.index].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].getCard()
    
    @IBOutlet weak var drawing: SplineView!
    
    @IBOutlet weak var buttonPanel: ButtonView!
    
    @IBOutlet weak var whiteButton: Changer!
    
    @IBOutlet weak var blackButton: Changer!
    
    @IBOutlet weak var greenButton: Changer!
    
    @IBOutlet weak var blueButton: Changer!
    
    @IBOutlet weak var redButton: Changer!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func whitePress(_ sender: Any) {
        changePressed(pressor: whiteButton)
        drawing.setPath(fore: whiteButton.getColor(), store: whiteButton.getColor(), width: wid)
    }
    
    @IBAction func blackPress(_ sender: Any) {
        changePressed(pressor: blackButton)
        drawing.setPath(fore: blackButton.getColor(), store: blackButton.getColor(), width: wid)
    }
    
    @IBAction func greenPress(_ sender: Any) {
        changePressed(pressor: greenButton)
        drawing.setPath(fore: greenButton.getColor(), store: greenButton.getColor(), width: wid)
    }

    @IBAction func bluePress(_ sender: Any) {
        changePressed(pressor: blueButton)
        drawing.setPath(fore: blueButton.getColor(), store: blueButton.getColor(), width: wid)
    }
    
    @IBAction func redPress(_ sender: Any) {
        changePressed(pressor: redButton)
        drawing.setPath(fore: redButton.getColor(), store: redButton.getColor(), width: wid)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        buttonPanel.delegate = self
        drawing.setPath(fore: UIColor.white, store: UIColor.white, width: 1)
        wid = 10
        slider.minimumValue = 0
        slider.maximumValue = 2
        slider.isContinuous = false
        slider.thumbTintColor = UIColor.white
        slider.maximumTrackTintColor = #colorLiteral(red: 0.7484021976, green: 0.867255727, blue: 0.9230052348, alpha: 1)
        slider.minimumTrackTintColor = #colorLiteral(red: 0.2922508899, green: 0.4291476236, blue: 0.8521057853, alpha: 1)
        slider.value = 1
    }
    
    func changePressed(pressor: Changer) {
        whiteButton.setPressed(press: false)
        redButton.setPressed(press: false)
        blueButton.setPressed(press: false)
        greenButton.setPressed(press: false)
        blackButton.setPressed(press: false)
        
        pressor.setPressed(press: true)
        
        whiteButton.changePress()
        redButton.changePress()
        blueButton.changePress()
        greenButton.changePress()
        blackButton.changePress()
    }
    
    @IBAction func doSlide(_ sender: Any) {
        wid = CGFloat(pow(10.0, slider.value))
        drawing.setPath(fore: drawing.getForeColor(), store: drawing.getForeColor(), width: wid)
    }
    
    func doSwipeUp() {
        if (publicindex.cardindex == 0 )
        {
            return
        }
        else
        {
           MainMenuData.debates[MainMenuData.index].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            
            drawing.setCard(tempCard: MainMenuData.debates[MainMenuData.index].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex - 1].getCard())
            
            publicindex.cardindex -= 1
        }
    }
    
    func doSwipeLeft() {
        
    }
    
    func doSwipeRight() {
        
    }
    func doSwipeDown() {
        MainMenuData.debates[MainMenuData.index].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
        
       drawing.clearDraw()
        MainMenuData.debates[MainMenuData.index].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes.append(CardView(draw: drawing.getLayered(), coder: NSCoder()))
        
        publicindex.cardindex += 1
    }
}
