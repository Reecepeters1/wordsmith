//
//  Flow.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 12/7/17.
//  Copyright © 2017 District196. All rights reserved.
//

import Foundation
import UIKit

class Flow: UICollectionView{

    var herpes: [CardView] = []
    
    override func cellForItem(at indexPath: IndexPath) -> CardView
    {
        //1
        let cell =  self.dequeueReusableCell(withReuseIdentifier: "Card",
                                                      for: indexPath) as! CardView
        cell.backgroundColor = UIColor.black
        return cell
    }
}
