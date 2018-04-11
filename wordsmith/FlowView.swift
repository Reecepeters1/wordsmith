//
//  CollectionView.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit


//see the bottom to see th eextension for this
protocol FlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, heightForCardAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
}

class FlowVeiw: UICollectionViewController{
    
    
    var index:Int = -1
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech] = []
    var currentflow: Int = 0
    var syphilis:Flow = MainMenuData.debates[index].positions[currentflow]
    
    //var itemsPerRow:CGFloat
    var generic = CardView()
    var itemsPerColumn:CGFloat = syphilis.longestcolumn()
    
    var itemSize: CGSize {
        get{
        
        }
        set{
            
        }
        
    }
    
    
    override func viewDidLoad() {
        self.collectionView!.dataSource = self
    }
    
}
extension FlowVeiw{
    
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
    
    func gettrueindex(Index: IndexPath){
        //TODO
        //var item = Index.item
        //for 0...syphilis.count
    }
    
}


extension FlowVeiw: UICollectionViewDelegateFlowLayout{
    
    //this function sets size of a cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        let availableHeight = self.view.frame.height
        let heightPerItem = availableHeight / itemsPerColumn
        
        return CGSize(width: heightPerItem, height: heightPerItem)
    }
    
    
    //return spacing between cards between rows
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        //TODO adjust for end spech value speech
        //let availableHeight = self.view.frame.height
        //let heightPerItem = availableHeight / itemsPerColumn
        return sectionInsets
    }
    
    //return spacing between cards between columns
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







