//
//  FlowCollectionView.swift
//  wordsmith
//
//  Created by freddie on 4/22/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class FlowCollectionView: UICollectionView{
    var generic = UICollectionViewCell()
    var debateindex = 0
    var currentflow = 0
    
    //just some generic setters
    func setdebateindex(i:Int) -> Void{
        debateindex = 1
    }
    func setcurrentflow(i:Int) -> Void{
        currentflow = i
    }
    /*
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if MainMenuData.debates[debateindex].positions[0].Speeches.count == 0{
            return 1
        }
        for counter1 in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches.count{
            for _ in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches[counter1].getcount()
            {
                count += 1
            }
        }
        
        return count
        
    }
     */
    //this function creates cell and places it at the intend position
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        print("this is working")
        var cell = dequeueReusableCell(index: indexPath.item)
        if cell.isEndOfSpeech == true{
            cell = super.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
            return cell
        }
        return cell
    }
    
    func dequeueReusableCell(index: Int) -> CardView{
        var counter = 0
        for forloopcounter1 in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches.count {
            for forloopcounter2 in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches[forloopcounter1].getcount() {
                if counter == index{
                    return MainMenuData.debates[debateindex].positions[currentflow].Speeches[forloopcounter1].getcard(Index: forloopcounter2)
                }
                else{
                    counter += 1
                }
            }
        }
        //this should never run
        return generic as! CardView
    }
}


