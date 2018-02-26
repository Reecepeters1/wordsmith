//
//  FlowViewLayout.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/18/17.
//  Copyright © 2017 District196. All rights reserved.


import UIKit
protocol FlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView:UICollectionView, heightForCardAtIndexPath indexPath:IndexPath) -> CGFloat
}
class FlowVeiwLayout: UICollectionViewFlowLayout{
    
    
    weak var delegate: FlowLayoutDelegate!
    
    // placeholder values
    //public var position = CardView[1][1]() dunno if we need this yet

    var numberOfColumns = 8
    var cellPadding: CGFloat = 6
    var contentHeight: CGFloat = 0
    var screenWidth = UIScreen.main.bounds.size.width
    var screenHeight = UIScreen.main.bounds.size.height
    
    // fuck if I know what this is
    var cache = [UICollectionViewLayoutAttributes]()
    
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
        return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    
    // sets card height/width
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override init() {
        super.init()
        setup()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
    }
    
    //prepare
    override func prepare() {
        // 1
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        // variable casting for numer of items
        let items = collectionView.numberOfItems(inSection: 0)
        let itemdouble = Double(items)
        let itemCGFloat = CGFloat(itemdouble)
        
        //variable instantiations
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        
        // actualy proccess by which we auto size card layout
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
        
            // 4
            let CardHeight = screenHeight / (itemCGFloat / CGFloat(numberOfColumns))//read here
            let height = cellPadding * 2 + CardHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
