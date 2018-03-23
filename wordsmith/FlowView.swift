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
    //public var itemPerRow = 4 placeholderfornow
    

    var sectionInsets = UIEdgeInsets(top: 40.0, left: 20.0, bottom: 40.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var itemsPerRow: CGFloat = 4
    
    var itemsPerColumn: CGFloat = 4
    var numberofitems = 10
    var siphylis: Flow?
    
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
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    CardView
    {
        //1
        let cell = siphylis.
        
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






