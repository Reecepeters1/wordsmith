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
    
    var generic:CardView
    var currentCard: CardView
    var wid: CGFloat = 10
    let coder:NSCoder
    required init?(coder aDecoder: NSCoder) {
        self.coder = aDecoder
        self.generic = CardView(draw: [CAShapeLayer](), coder: aDecoder)!
        if MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes.count == 0{
            currentCard = generic
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes.append(generic)
        }
        else{
            currentCard = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex]
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
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
            
            drawing.clearDraw()
            
            drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex - 1].storedCard)
            publicindex.cardindex -= 1
        }
    }
    
    func doSwipeLeft() {
        let response: Bool = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard == nil

        if (response) {
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
            drawing.clearDraw()
            
            performSegue(withIdentifier: "WRONG_LEVER", sender: self)
        }
        else
        {
            
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
            
            let newSpeech = publicindex.currentspeech - 1
            let newCard = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes.index(of: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard!)
            
            print(newCard!)
            print(newSpeech)
            
            drawing.clearDraw()
            drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes[newCard!].storedCard)
            
            publicindex.currentspeech = newSpeech
            publicindex.cardindex = newCard!
            
        }
    }
    
    func doSwipeRight() {
        
        print(publicindex.cardindex)
        print(publicindex.currentspeech)
        MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
        
        MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
        
        let newSpeech = publicindex.currentspeech + 1
        
        if MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.hasResponses()
        {
            let newCard = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes.index(of: (MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.responses[0]))
            drawing.clearDraw()
            drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes[newCard!].storedCard)
            
            print("has")
            
            publicindex.currentspeech = newSpeech
            publicindex.cardindex = newCard!
        } else {
            if MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.count == newSpeech {
                let newCardView: [CardView] = [CardView]()
                MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.append(Speech(array: newCardView))
                
                print("new")
            }
            let newCard = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes.count
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes.append(CardView(draw: [CAShapeLayer](), coder: coder)!)
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes[newCard].storedCard.isAResponse = true
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes[newCard].storedCard.setPreviousCard(hey: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex])
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setHasResponses(hey: true)
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.responses.append(MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes[newCard])
            
            print("else")
            
            drawing.clearDraw()
            drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[newSpeech].herpes[newCard].storedCard)
    
            publicindex.cardindex = newCard
            publicindex.currentspeech = newSpeech

        }
    }
    
    func doSwipeDown() {
        
            print(publicindex.currentspeech)
        print(publicindex.cardindex)
        MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].setCard(car: drawing.getCard())
        
        MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.setImage(set: drawing.pb_takeSnapshot())
        
        if MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.isAResponse
        {
            drawing.clearDraw()
            
            let newCard = publicindex.cardindex + 1
            
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes.insert(CardView(draw: drawing.getLayered(), coder: coder )!, at: newCard)
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.responses.append(MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[newCard])
            
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[newCard].storedCard.setHasResponses(hey: true)
            MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[newCard].storedCard.previousCard = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex].storedCard.previousCard
            
            drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[newCard].storedCard)
            
            publicindex.cardindex = newCard
            return
        } else if publicindex.cardindex != MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes.count - 1 {
            drawing.clearDraw()
            drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex + 1].storedCard)
            publicindex.cardindex += 1
        } else {
        
        drawing.clearDraw()
        MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes.append(CardView(draw: drawing.getLayered(), coder: coder)!)
        
        drawing.setCard(tempCard: MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[publicindex.currentspeech].herpes[publicindex.cardindex + 1].storedCard)
        
        publicindex.cardindex += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        drawing.clearDraw()
        for i in MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches {
            i.herpes.append(CardView(draw: drawing.getLayered(), coder: coder)!)
            i.herpes[i.herpes.count - 1].isEndOfSpeech = true
        }
        publicindex.currentspeech = 0
    }
}

