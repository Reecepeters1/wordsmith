//
//  FlowViewLayout.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/18/17.
//  Copyright © 2017 District196. All rights reserved.


import UIKit

protocol FlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, heightForCardAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
}


class FlowVeiwLayout: UICollectionViewLayout{
   
    var delegate: FlowLayoutDelegate!
    fileprivate var numberOfColumns = 1
    fileprivate var cellPadding: CGFloat = 6
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentWidth * CGFloat(2))
    }
    
    //array that holds attribute of the cards
    var cache = [UICollectionViewLayoutAttributes]()
    
    
    
    override public func prepare(){
        guard cache.isEmpty == true, var collectionView = collectionView else {
            return
        }
        collectionView = collectionView as! FlowCollectionView
        
        
        //clear the cache for repopulation
        cache.removeAll()
        
        //items casting and variable instantiations
        
        
        //set y and x offset to zero
        var yOffset:CGFloat = 0
        var xOffset:CGFloat = 0
        
        // actualy proccess by which we auto size card layout
        for item in 0 ... 5//collectionView.numberOfItems(inSection: 0)
        {
            let indexPath = IndexPath(item: item, section: 0)

            let CellHeight = delegate.collectionView(collectionView, heightForCardAtIndexPath: indexPath)
            let CellWidth = CellHeight
            
            //item(the interator) castingto CGFloat so the math works
            let itemdouble = Double(item)
            let itemCGFloat = CGFloat(itemdouble)
            
            if item == 0{
                yOffset = 50
                xOffset = 20
            }
            
            //calculate the coordinates here
            else
            {
                let temp = collectionView.cellForItem(at: indexPath) as! CardView
                ;if temp.isItEndOfSpeech() == true
                {
                    xOffset += cellPadding * itemCGFloat + itemCGFloat * CellWidth
                }
            
                //creates and indents the frame to be place inside cache
                let frame = CGRect(x: xOffset, y: yOffset, width: CellWidth, height: CellHeight)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                
                yOffset += cellPadding
                cache.append(attributes)
            }
            //collectionViewContentSize = CGSize(width: yOffset, height: xOffset)
            
        }
    }
    
    
    
    //this is depreciated RIP old partner
    /*override func prepare()
     
     //variable instantiations
     let columnWidth = ( screenWidth / CGFloat(numberOfColumns) )
     var xOffset = [CGFloat]()
     
     for counter in 0 ..< numberOfColumns
     {
     xOffset.append(CGFloat(counter) * columnWidth)
     }
     var column = 0
     
     var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
     
     // actualy proccess by which we auto size card layout
     for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
     
     let indexPath = IndexPath(item: item, section: 0)
     
     
     let CardHeight = screenHeight / (itemCGFloat / CGFloat(numberOfColumns))
     let height = cellPadding * 2 + CardHeight
     
     
     
     let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: columnWidth)
     let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
     
     
     let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
     attributes.frame = insetFrame
     cache.append(attributes)
     
     
     contentHeight = max(contentHeight, frame.maxY)
     yOffset[column] = yOffset[column] + height
     column = column < (numberOfColumns - 1) ? (column + 1) : 0
     
     //check if card is end of speech
     let temp = collectionView.cellForItem(at: indexPath) as! CardView
     if temp.isItEndOfSpeech() == true
     {
     
     }
     }
     }*/
    
    
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache
        {
            if attributes.frame.intersects(rect)
            {
                visibleLayoutAttributes.append(attributes)
                print("this works")
            }
            visibleLayoutAttributes.append(attributes)
        }
        
        return visibleLayoutAttributes
    }
    
    
    //returns layout attribute for a specific item
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        return cache[indexPath.item]
    }
}


