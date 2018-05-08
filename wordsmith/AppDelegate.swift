//
//  AppDelegate.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 12/6/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /*let tempround = Debate.Round()
        let tempballot = Debate.Ballot()
        let temp = Debate(round: tempround, otherTeam: "", ballot: tempballot, judgeName: [""], tournament: "", side: .aff)
        MainMenuData.debates.append(temp)
        MainMenuData.debates.append(temp)
        */
        // Override point for customization after application launch.
        /*let myViewController = UIViewController()
        myViewController.view = UIView(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        myViewController.view.backgroundColor = UIColor.red
        window?.rootViewController = myViewController
        window?.makeKeyAndVisible()*/
        
        return true
        }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }



}

