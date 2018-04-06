//
//  CollectionView.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit


class FlowVeiw: UICollectionViewController{
    
    var index:Int = -1
    var sectionInsets = UIEdgeInsets(top: 40.0, left: 20.0, bottom: 40.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech]
    var syphilis:Flow
    var itemsPerRow:CGFloat
    var itemsPerColumn:CGFloat
    
    

    
    //throws a hissy fit if I don't have this for some reason
    required init(coder decoder: NSCoder) {
        copyover = []
        syphilis = Flow(array: copyover)
        itemsPerColumn = CGFloat(syphilis.longestcolumn())
        itemsPerRow = CGFloat(syphilis.Speeches.count) + 1
        super.init(coder: decoder)!
    }
    
}
extension FlowVeiw{
    
    func dequeueReusableCell(index: Int) -> CardView{
        var counter = 0
        if
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
        
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        let x = 10
        return x
    }
    
    //this function creates cell and places it at the intend position
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CardView
    {
        
        let cell = self.dequeueReusableCell(index: indexPath.item)
        return cell
    }
    
    /*func gettrueindex(Index: IndexPath){
        var item = Index.item
        for 0...syphilis.count
    }*/
    
}


extension FlowVeiw: UICollectionViewDelegateFlowLayout{
    
    //this function sets size of a cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = self.view.frame.width
        let widthPerItem = availableWidth / itemsPerRow - sectionInsets.left
        
        let availableHeight = self.view.frame.height
        let heightPerItem = availableHeight / itemsPerColumn - sectionInsets.top
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    //4
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







