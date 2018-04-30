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
    public static var speech = 0
    public static func setindex(index:IndexPath) -> Void{
        var count = 0
        if MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.count == 0
        {
            publicindex.speech = 0
            publicindex.cardindex = 0
            return
        }
        for x in 0..<MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches.count{
            
            for z in 0..<MainMenuData.debates[publicindex.debateindex].positions[publicindex.currentflow].Speeches[x].getcount(){
                if count == index.item{
                    publicindex.speech = x
                    publicindex.cardindex = z
                }
                else{
                    count+=1
                }
            }
        }
    }
}

class FlowVeiw: UICollectionViewController{
    
    
    @IBOutlet var FlowCollectionView: FlowCollectionView!
    
    var debateindex:Int = 0
    var sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let reuseIdentifier = "Card"
    var currentflow:Int = 0
    //this is here so i can run longest column method in the init
    var syphilis:Flow
    var generic = UICollectionViewCell()
    var itemsPerColumn:CGFloat
    
    
    
    
    func setdebateindex(i: Int){
        self.debateindex = i
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.syphilis = MainMenuData.debates[debateindex].positions[currentflow]
        self.itemsPerColumn = CGFloat(syphilis.longestcolumn())
        publicindex.debateindex = debateindex
        publicindex.currentflow = currentflow
        publicindex.cardindex = 0
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        FlowCollectionView.delegate = self
        FlowCollectionView.setdebateindex(i: debateindex)
        FlowCollectionView.setcurrentflow(i: currentflow)
        if let layout = collectionView?.collectionViewLayout{
            let Flowlayout = layout as! FlowVeiwLayout
            Flowlayout.delegate = self
        }
        super.viewDidLoad()
    }
    
}

extension FlowVeiw{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        var count = 1
        
        if MainMenuData.debates[debateindex].positions[0].Speeches.count == 0{
            return 1
        }
        for counter1 in 0...(MainMenuData.debates[debateindex].positions[currentflow].Speeches.count - 1){
            for _ in 0...(MainMenuData.debates[debateindex].positions[currentflow].Speeches[counter1].getcount() - 1)
            {
                count += 1
            }
        }
        return count
        
    }
    //this function creates cell and places it at the intend position
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CardView
    {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
        if MainMenuData.debates[debateindex].positions[currentflow].Speeches.isEmpty{
            return cell
        }
        if cell.isEndOfSpeech == true{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addcard", for: indexPath) as! CardView
            return cell
        }
        return cell
    }
    
    func dequeueReusableCell(index: Int) -> CardView{
        var counter = 0
        for forloopcounter1 in 0..<MainMenuData.debates[debateindex].positions[currentflow].Speeches.count{
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
    //sets the public index at the index path
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let temp =  collectionView!.indexPathsForSelectedItems![0]
        publicindex.setindex(index: temp)
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
        if x > 200 {
            return CGFloat(200)
        }
        if x < 100{
            return CGFloat(100)
            
        }
        return CGFloat(z)
    }
}








