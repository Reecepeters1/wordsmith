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
    
    var floe = MainMenuData.debates[MainMenuData.index].positions[publicindex.currentflow]
    var generic = CardView(coder: NSCoder())
    var currentCard:CardView
    var wid:CGFloat = 10
    required init?(coder aDecoder: NSCoder) {
        if floe.Speeches[publicindex.currentspeech].herpes.count == 0{
            currentCard = generic!
            floe.Speeches[publicindex.currentspeech].herpes.append(generic!)
        }
        else{
            currentCard = floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex]
        }
        super.init(coder: aDecoder)
    }
    
    
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
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
            
            drawing.setCard(tempCard: floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex - 1].getCard())
            publicindex.cardindex -= 1
        }
    }
    
    func doSwipeLeft() {
        let response: Bool = floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard == nil
        
        if (response) {
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
            
            performSegue(withIdentifier: "WRONG_LEVER", sender: self)
        }
        else
        {
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
            
            let newSpeech = publicindex.currentspeech - 1
            
            let newCard = floe.Speeches[newSpeech].herpes.index(of: (floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard?.holder)!)
            
            drawing.setCard(tempCard: floe.Speeches[newSpeech].herpes[newCard!].getCard())
            
            publicindex.currentspeech = newSpeech
            publicindex.cardindex = newCard!
            
        }
    }
    
    func doSwipeRight() {
        floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
        
        floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
        
        let newSpeech = publicindex.currentspeech + 1
        
        if floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.hasResponses()
        {
            let newCard = floe.Speeches[newSpeech].herpes.index(of: (floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.responses[0].holder))
            drawing.setCard(tempCard: floe.Speeches[newSpeech].herpes[newCard!].getCard())
            
            publicindex.currentspeech = newSpeech
            publicindex.cardindex = newCard!
            return
        } else {
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setHasResponses(hey: true)
            
            var newCard: Int
            
            if floe.Speeches.count == newSpeech {
                newCard = 0
            } else {
                newCard = floe.Speeches[newSpeech].herpes.count
            }
            
            drawing.clearDraw()
            floe.Speeches[newSpeech].herpes.append(CardView(draw: drawing.getLayered(), coder: NSCoder())!)
            
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.responses[0] = floe.Speeches[newSpeech].herpes[newCard].storedCard
            
            floe.Speeches[newSpeech].herpes[newCard].storedCard.isAResponse = true
            
            drawing.setCard(tempCard: floe.Speeches[newSpeech].herpes[newCard].storedCard)
            
            publicindex.cardindex = newCard
            publicindex.currentspeech = newSpeech
            return
        }
    }
    
    func doSwipeDown() {
        floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
        
        floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
        
        let newCard = publicindex.cardindex + 1
        
        if floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.isAResponse && ((newCard == floe.Speeches[publicindex.currentspeech].herpes.count) || !(floe.Speeches[publicindex.currentspeech].herpes[newCard].storedCard.isAResponse) )
        {
            drawing.clearDraw()
            floe.Speeches[publicindex.currentspeech].herpes.insert(CardView(draw: drawing.getLayered(), coder: NSCoder() )!, at: floe.Speeches[publicindex.currentspeech].herpes.index(of: (floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.holder))! + 1)
            floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard?.responses.append(floe.Speeches[publicindex.currentspeech].herpes[newCard].storedCard)
            
            floe.Speeches[publicindex.currentspeech].herpes[newCard].storedCard.previousCard = floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard
            
            floe.Speeches[publicindex.currentspeech].herpes[newCard].storedCard.isAResponse = true
            
            drawing.setCard(tempCard: floe.Speeches[publicindex.currentspeech].herpes[newCard].storedCard)
            
            publicindex.cardindex = newCard
            return
        }
        
        drawing.clearDraw()
        floe.Speeches[publicindex.currentspeech].herpes.append(CardView(draw: drawing.getLayered(), coder: NSCoder())!)
        
        drawing.setCard(tempCard: floe.Speeches[publicindex.currentspeech].herpes[publicindex.cardindex + 1].getCard())
        
        publicindex.cardindex += 1
    }
}
