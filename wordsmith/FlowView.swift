//
//  CollectionView.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit


//see the bottom to see the eextension for this
public class publicindex: NSObject{
    public static var debateindex:Int = 0
    public static var currentflow = 0
    public static var cardindex = 0
    public static var currentspeech = 0
    
    
    public static func setindex(index:IndexPath) -> Void{
        var count = 0
        if MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.count == 0
        {
            currentspeech = 0
            publicindex.cardindex = 0
            return
        }
        for x in 0..<MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.count{
            
            for z in 0..<MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[x].getcount(){
                if count == index.item{
                    publicindex.currentspeech = x
                    publicindex.cardindex = z
                }
                else{
                    count+=1
                }
            }
        }
    }
}

class FlowVeiw: UICollectionViewController{
    
    
    @IBOutlet var FlowCollectionView: FlowCollectionView!
    
    var debateindex:Int = 0
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var currentflow:Int = 0
    //this is here so i can run longest column method in the init
    var syphilis:Flow
    var generic = UICollectionViewCell()
    var itemsPerColumn:CGFloat
    
    
    
    
    func setdebateindex(i: Int){
        self.debateindex = i
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.syphilis = MainMenuData.debates[debateindex].positions[currentflow]
        self.itemsPerColumn = CGFloat(syphilis.longestcolumn())
        publicindex.debateindex = debateindex
        publicindex.currentflow = currentflow
        publicindex.cardindex = 0
        addcard = CardView(coder: aDecoder)!
        toodles1 = CardView(coder: aDecoder)!
        toodles2 = CardView(coder: aDecoder)!
        toodles3 = CardView(coder: aDecoder)!
        toodles4 = CardView(coder: aDecoder)!
        toodles5 = CardView(coder: aDecoder)!
        toodles6 = CardView(coder: aDecoder)!
        toodles7 = CardView(coder: aDecoder)!
        toodles8 = CardView(coder: aDecoder)!
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches.append(temp1)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches.append(temp2)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches.append(temp3)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[0].herpes.append(toodles1)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[0].herpes.append(toodles2)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[0].herpes.append(toodles3)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[0].herpes[2].isEndOfSpeech = true
        
        
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[1].herpes.append(toodles4)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[1].herpes.append(toodles8)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[1].herpes[1].isEndOfSpeech = true
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[2].herpes.append(toodles5)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[2].herpes.append(toodles6)
        MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches[2].herpes[1].isEndOfSpeech = true
        /*
         toodles4.storedCard.responses.append(toodles5)
         toodles5.storedCard.isAResponse = true
         toodles4.storedCard.responses.append(toodles6)
         toodles6.storedCard.isAResponse = true
         */
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        FlowCollectionView.delegate = self
        FlowCollectionView.setdebateindex(i: debateindex)
        FlowCollectionView.setcurrentflow(i: currentflow)
        if let layout = collectionView?.collectionViewLayout{
            let Flowlayout = layout as! FlowVeiwLayout
            Flowlayout.delegate = self
        }
        super.viewDidLoad()
    }
    
}

extension FlowVeiw{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        var count = 1
        
        if MainMenuData.debates[debateindex].positions[publicindex.currentspeech].Speeches.count == 0{
            return 1
        }
        for counter1 in 0...(MainMenuData.debates[debateindex].positions[currentflow].Speeches.count - 1){
            for _ in 0...(MainMenuData.debates[debateindex].positions[currentflow].Speeches[counter1].getcount() - 1)
            {
                count += 1
            }
        }
        return count
        
    }
    //this function creates cell and places it at the intend position
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CardView
    {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
        if MainMenuData.debates[debateindex].positions[currentflow].Speeches.isEmpty{
            return cell
        }
        
        publicindex.setindex(index: indexPath)
        cell = MainMenuData.debates[debateindex].positions[currentflow].Speeches[publicindex.currentspeech].getcard(Index: publicindex.cardindex)
        
        if cell.isEndOfSpeech == true{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
            return cell
        }
        return cell
    }
    
    func dequeueReusableCell(index: Int) -> CardView{
        var counter = 0
        for forloopcounter1 in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches.count{
            for forloopcounter2 in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches[forloopcounter1].getcount() {
                if counter == index{
                    return MainMenuData.debates[debateindex].positions[currentflow].Speeches[forloopcounter1].getcard(Index: forloopcounter2)
                }
                else{
                    counter += 1
                }
            }
        }
        //this should never run
        return generic as! CardView
    }
    //sets the public index at the index path
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let temp =  collectionView!.indexPathsForSelectedItems![0]
        publicindex.setindex(index: temp)
        /*
         if MainMenuData.debates[debateindex].positions[publicindex.debateindex].Speeches[0].herpes.count == 1{
         temp.item = 0
         }
         else{
         temp.item = MainMenuData.debates[debateindex].positions[publicindex.debateindex].Speeches[0].herpes.count - 1
         
         }
         for flw in MainMenuData.debates[debateindex].positions{
         for spch in flw.Speeches{
         if spch.herpes[spch.herpes.count - 1] == addcard{
         spch.herpes.remove(at: spch.herpes.count - 1)
         }
         }
         }
         */
    }
}
extension FlowVeiw: UICollectionViewDelegateFlowLayout{
    
    //this function sets size of a cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableHeight = self.view.frame.height
        let heightPerItem = availableHeight / itemsPerColumn
        
        return CGSize(width: heightPerItem, height: heightPerItem)
        
    }
    
    
    //return spacing between cards between rows
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        //TODO adjust for end spech value speech
        //let availableHeight = self.view.frame.height
        //let heightPerItem = availableHeight / itemsPerColumn
        return sectionInsets
    }
    
    //return spacing between cards between columns
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
extension FlowVeiw: FlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForCardAtIndexPath indexPath:IndexPath) -> CGFloat {
        let x = self.view.frame.height
        let y = itemsPerColumn
        let z = x / y
        if x > 200 {
            return CGFloat(200)
        }
        if x < 100{
            return CGFloat(100)
            
        }
        return CGFloat(z)
    }
}


