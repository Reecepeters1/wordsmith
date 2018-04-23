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
    
    
    @IBOutlet var FlowCollectionView: FlowCollectionView!
    
    var debateindex:Int = 0
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech]
    var currentflow:Int = 0
    var syphilis:Flow
    //var itemsPerRow:CGFloa
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
        FlowCollectionView.delegate = self
        FlowCollectionView.setdebateindex(i: debateindex)
        FlowCollectionView.setcurrentflow(i: currentflow)
        super.viewDidLoad()
    }
}

extension FlowVeiw{
    
    /*func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView,
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        var cell = dequeueReusableCell(index: indexPath.item)
        
        if cell.isEndOfSpeech == true{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
            return cell
        }
        return cell
    }*/
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
        return CGFloat(z)
    }
}







