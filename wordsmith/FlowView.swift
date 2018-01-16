//
//  CollectionView.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

final class FlowVeiw: UICollectionViewController {
    fileprivate let itemsPerRow: CGFloat = 3
    // MARK: - Properties
    fileprivate let reuseIdentifier = "Debate"
    
}
extension FlowVeiw : UICollectionViewDelegateFlowLayout {
    //1
    /*func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
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
    }*/
}
 /*override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //1
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! FlickrPhotoCell
    //2
    let flickrPhoto = photoForIndexPath(indexPath: indexPath)
    cell.backgroundColor = UIColor.white
    //3
    cell.imageView.image = flickrPhoto.thumbnail
    
    return cell
 
}*/
extension FlowVeiw {
    //1
    /*override func numberOfSections(in collectionView: UICollectionView) -> Int {
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {

    }
    */
    //3
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.black
        return cell
    }
}

