//
//  MainScreen.swift
//  wordsmith/Users/802781/Documents/wordsmith/wordsmith/MainScreen.swift
//
//  Created by KRUEGER, JOHN on 1/24/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import os.log

//This class contains our actual debate objects.
public class MainMenuData: NSObject {
    
    static var debates:[Debate] = []
    
}

import UIKit

class MainMenuTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MainMenuData.debates.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "debateCell", for: indexPath)
        
     var localString = MainMenuData.debates[indexPath.row].otherTeam ?? "slytherine"
     localString.append(" ")
     localString.append(MainMenuData.debates[indexPath.row].tournament ?? "Hogwarts")
     
    cell.textLabel?.text? = localString
    
     return cell
     }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "DebateView") as! DebateDetailViewController
        local.debateIndex = indexPath.row
        splitViewController?.showDetailViewController(local, sender: nil)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Enables deletion of debates from the table.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let temp = indexPath.row - 1
            
            
            MainMenuData.debates.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //segue to create viw if the array is now empty.
            
            let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
            local.debateIndex = temp
            splitViewController?.showDetailViewController(local, sender: nil)
            
        }
    }
    
    @IBAction func createDebate(_ sender: UIBarButtonItem) {
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "CreateDebate") as! CreateDebateViewController
        splitViewController?.showDetailViewController(local, sender: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class DebateDetailViewController: UIViewController {
    
    var debateIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (MainMenuData.debates.isEmpty) {
            
            let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "CreateDebate")
            splitViewController?.showDetailViewController(local, sender: nil)
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func launch(_ sender: Any) {
        print("starting transfer")
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "masterView") as! TransferViewController
        local.debateIndex = debateIndex
        splitViewController?.viewControllers[0] = local
        print("Transfer Complete")
    }
    
    @IBAction func modify(_ sender: Any) {
        
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "ModifyDebate") as! ModifyDebateViewController
        local.debateIndex = debateIndex
        splitViewController?.showDetailViewController(local, sender: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class CreateDebateViewController: UIViewController {
    
    private enum defaults {
        
    }
    
    
    @IBOutlet weak var titleFIeld: UITextField!
    
    @IBOutlet weak var roundField: UITextField!
    
    @IBOutlet weak var opponentField: UITextField!
    
    @IBOutlet weak var judgeField: UITextField!
    
    @IBOutlet weak var tournamentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "DebateView") as! DebateDetailViewController
        
        splitViewController?.showDetailViewController(local, sender: nil)
    }
    
    @IBAction func create(_ sender: Any) {
        
        
        
        MainMenuData.debates.append(local)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class ModifyDebateViewController: UIViewController {
    
    var debateIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "DebateView") as! DebateDetailViewController
        local.debateIndex = debateIndex
        splitViewController?.showDetailViewController(local, sender: nil)
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

