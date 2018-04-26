//
//  CollectionView.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 12/11/17.
//  Copyright © 2017 District196. All rights reserved.
//
import Foundation
import UIKit


//see the bottom to see the eextension for this
public class publicindex: NSObject{
    public static var debateindex:Int = 0
    public static var currentflow = 0
    public static var cardindex = 0
    
}

class FlowVeiw: UICollectionViewController{
    
    
    @IBOutlet var FlowCollectionView: FlowCollectionView!
    
    var debateindex:Int = 0
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var copyover:[Speech]
    var currentflow:Int = 0
    var syphilis:Flow
    //var itemsPerRow:CGFloa
    var generic = UICollectionViewCell()
    var itemsPerColumn:CGFloat
    var layout = FlowVeiwLayout()
    
    
    
    func setdebateindex(i: Int){
        self.debateindex = i
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.syphilis = MainMenuData.debates[debateindex].positions[currentflow]
        self.itemsPerColumn = CGFloat(syphilis.longestcolumn())
        copyover = []
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        FlowCollectionView.delegate = self
        FlowCollectionView.setdebateindex(i: debateindex)
        FlowCollectionView.setcurrentflow(i: currentflow)
        self.automaticallyAdjustsScrollViewInsets = false
        publicindex.debateindex = debateindex
        publicindex.currentflow = currentflow
        publicindex.cardindex = 0
        super.viewDidLoad()
    }
}

extension FlowVeiw{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView,
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
    //this function creates cell and places it at the intend position
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        print("this is working")
        var cell = dequeueReusableCell(index: indexPath.item)
        if cell.isEndOfSpeech == true{
            cell = FlowCollectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
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
        let x = self.view.frame.height
        let y = itemsPerColumn
        let z = x / y
        if z > 200{
            return CGFloat(200)
        }
        return CGFloat(z)
    }
}







