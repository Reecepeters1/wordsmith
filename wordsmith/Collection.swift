//
//  Collection.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 4/11/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit
class Collection: UICollectionView {
    var index:Int = 0
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech] = []
    var currentflow: Int = 0
    var syphilis:Flow = MainMenuData.debates[index].positions[currentflow]
    
    //var itemsPerRow:CGFloat
    var generic = CardView()
    var itemsPerColumn:CGFloat = syphilis.longestcolumn()
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
        return generic
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if MainMenuData.debates[index].positions[0].Speeches.count == 0{
            return 1
        }
        for counter1 in 0...(MainMenuData.debates[index].positions[currentflow].Speeches.count - 1){
            for _ in 0...(MainMenuData.debates[index].positions[currentflow].Speeches[counter1].getcount() - 1)
            {
                count += 1
            }
        }
        
        return count
        
    }
    
    //this function creates cell and places it at the intend position
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CardView
    {
        var cell = dequeueReusableCell(index: indexPath.row)
        
        if cell.isEndOfSpeech == true{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
            return cell
        }
        cell = self.dequeueReusableCell(index: indexPath.item)
        if cell == nil{
            return generic
        }
        return cell
    }
}
