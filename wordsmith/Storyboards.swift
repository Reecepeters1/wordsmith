//
//  Storyboards.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 2/27/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

/*
 This enumeration contains a refrence to each of the projects storyboards as a case. The var instance returns a UIStoryboard.
 This makes sure that we have a neet and concise way to access our storboards that we can modify quickly and easily
 */
public enum AppStoryboard : String {
    
    case Main = "Main"
    case PreLogin = "LaunchScreen"
    case MainMenu = "MainMenu"
    
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
}
