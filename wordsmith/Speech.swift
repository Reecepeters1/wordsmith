//
//  Speech.swift
//  wordsmith
//
//  Created by SHIH, FREDERIC on 3/1/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
class Speech{
    var herpes: [CardView] = []
    
    func getcount() -> Int{
        return herpes.count
    }
    
    func getcard(Index: Int) -> CardView{
        return herpes[Index]
        
    }
}



