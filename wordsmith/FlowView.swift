//
//  CollectionView.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit


class FlowVeiw: UICollectionViewController {
    var index:Int = 0
    
    var sectionInsets = UIEdgeInsets(top: 40.0, left: 20.0, bottom: 40.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech]
    var syphilis:Flow
    var itemsPerRow:CGFloat
    var itemsPerColumn:CGFloat
    init(){
        copyover = []
        syphilis = Flow(array: copyover)
        itemsPerColumn = CGFloat(syphilis.longestcolumn())
        itemsPerRow = CGFloat(syphilis.Speeches.count)
        super.init(collectionViewLayout: UICollectionViewLayout())
        
       
    }
    
    //throws a hissy fit if I don't have this for some reason
    required init(coder decoder: NSCoder) {
        copyover = []
        syphilis = Flow(array: copyover)
        itemsPerColumn = CGFloat(syphilis.longestcolumn())
        itemsPerRow = CGFloat(syphilis.Speeches.count)
        
        super.init(coder: decoder)!
    }
    
}
extension FlowVeiw{
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
        //this needs to be fixed in the future
        let cell = syphilis.getcard(Speech: indexPath.item, Index: indexPath.row)
        return cell
    }
    
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







