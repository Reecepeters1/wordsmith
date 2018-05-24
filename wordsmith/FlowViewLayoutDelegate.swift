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
    fileprivate var numberOfColumns = CGFloat(MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.count)
    fileprivate var cellPadding: CGFloat = 6
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth * 3, height: contentWidth * 2)
    }
    
    //array that holds attribute of the cards
    var cache = [UICollectionViewLayoutAttributes]()
    
    
    func y4responses(celloffset: CGFloat, array:[CardView]) -> CGFloat{
        var y:CGFloat = 0
        for i in array{
            if i.storedCard.responses.count != 0{
                y += y4responses(celloffset: celloffset, array: i.storedCard.responses)
            }
            else{
                y += celloffset
            }
        }
        return y
    }
    
    override public func prepare(){
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        //clear the cache for repopulation
        cache.removeAll()
        
        
        //set y and x offset to basal values
        var yOffset:CGFloat = 50
        var xOffset:CGFloat = 20
        //to be used later
        //let long = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].longestcolumn()
        // actualy proccess by which we auto size card layout
        for var item in 0..<collectionView.numberOfItems(inSection: 0)
        {
            
            let indexPath = IndexPath(item: item, section: 0)
            publicindex.setindex(index: indexPath)
            
            let CellHeight = delegate.collectionView(collectionView, heightForCardAtIndexPath: indexPath)
            let CellWidth = CellHeight
            
            //attributes creation and appends it onto cache
            let frame = CGRect(x: xOffset, y: yOffset, width: CellWidth, height: CellHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            let flw = MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow]
            
            //check to see if the card has respones and changes based on that
            if flw.Speeches[publicindex.currentspeech].herpes.count != 0
            {
                if flw.Speeches[publicindex.currentspeech].getcard(Index: publicindex.cardindex).storedCard.responses.count == 0
                {
                    yOffset += (CellWidth + CGFloat(30))
                    
                }
                else{
                    var responses = flw.Speeches[publicindex.currentspeech].getcard(Index: publicindex.cardindex).storedCard.responses
                    yOffset = y4responses(celloffset: (CellWidth + CGFloat(30)), array: responses)
                }
                
            }
            else{
                yOffset += (CellWidth + CGFloat(30))
            }
            //check if it's the end of the speech and move it adjust x offset accordingly
            if flw.longestcolumn() == 1 || flw.Speeches[publicindex.currentspeech].getcard(Index: publicindex.cardindex).isEndOfSpeech == true
            {
                xOffset += (CellWidth + CGFloat(20))
                yOffset = 50
            }
        }
        //collectionViewContentSize = CGSize(width: yOffset, height: xOffset)
        publicindex.currentspeech = 0
    }
    
    
    
    
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache
        {
            if attributes.frame.intersects(rect)
            {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    
    //returns layout attribute for a specific item
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        return cache[indexPath.item]
    }
}
