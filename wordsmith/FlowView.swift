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
    

    var sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate var flow = [UICollectionViewCell]()
    var itemsPerRow: CGFloat = 4
    var itemsPerColumn: CGFloat = 4
    var numberofitems = 10
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        let x = 10
        return x
    }
    
    
    
    //this function creates cell and places it at the intend position
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath)
        cell.backgroundColor = UIColor.black
        return cell
    }

}


extension FlowVeiw: UICollectionViewDelegateFlowLayout{
    
    //this function sets size of a cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        /*let toppaddingspace = sectionInsets.top * (itemsPerColumn + 1)
        let availableHeight = self.view.frame.height - toppaddingspace
        let heightPerItem = availableHeight / itemsPerColumn
        */
        
        return CGSize(width: widthPerItem, height: widthPerItem)
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
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
extension FlowVeiw: FlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForCardAtIndexPath indexPath:IndexPath) -> CGFloat {
        let x = Double(self.view.frame.height)
        let y = Double(itemsPerColumn)
        let z = x/y
        return CGFloat(z)
    }
}
extension FlowVeiw : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        
        for item in 0 ..< 40 {
            let indexPath = IndexPath(item: item, section: 0)
            let herp:UICollectionViewCell
            herp = collectionView!.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath)
            herp.backgroundColor = UIColor.black
            self.flow.append(herp)
            
        }
        self.collectionView?.reloadData()
        textField.text = nil
        return true
    }
}





