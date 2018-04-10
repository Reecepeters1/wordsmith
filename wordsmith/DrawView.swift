//
//  DrawView.swift
//  wordsmith
//
//  Created by PETERS, REECE on 4/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class DrawView: UIViewController {
    
    @IBOutlet weak var drawing: SplineView!
    
    override func viewDidLoad() {
        drawing.layer.borderWidth = 1
        drawing.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
}
