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


class FlowVeiw: UICollectionViewController{
    
    
    var debateindex:Int = 0
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech]
    var currentflow:Int = 0
    var syphilis:Flow
    
    //var itemsPerRow:CGFloat
    var generic = UICollectionViewCell()
    var itemsPerColumn:CGFloat
    
    func setdebateindex(i: Int){
        self.debateindex = i
    }
    required init?(coder aDecoder: NSCoder) {
        self.syphilis = MainMenuData.debates[debateindex].positions[currentflow]
        self.itemsPerColumn = CGFloat(syphilis.longestcolumn())
        copyover = []
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        
    }
}

extension FlowVeiw{
    
    
    func dequeueReusableCell(index: Int) -> CardView{
        var counter = 0
        for forloopcounter1 in 0...(syphilis.Speeches.count - 1){
            for forloopcounter2 in 0...(syphilis.Speeches[forloopcounter1].getcount() - 1) {
                if counter == index{
                    return syphilis.Speeches[forloopcounter1].getcard(Index: forloopcounter2)
                }
                else{
                    counter += 1
                }
            }
        }
        //this should never run
        return generic as! CardView
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if MainMenuData.debates[debateindex].positions[0].Speeches.count == 0{
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
        
        var cell = dequeueReusableCell(index: indexPath.item)
        
        //check for nil
        if cell == nil{
            return generic as! CardView
        }
        
        if cell.isEndOfSpeech == true{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
            return cell
        }
        return cell
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
        let x = Double(self.view.frame.height)
        let y = Double(itemsPerColumn)
        let z = x / y
        return CGFloat(z)
    }
}







