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
        
     var localString = MainMenuData.debates[indexPath.row].otherTeam
     localString.append(" ")
     localString.append(MainMenuData.debates[indexPath.row].tournament)
     
    cell.textLabel?.text? = localString
    
     return cell
     }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var opponentLabel: UILabel!
    
    @IBOutlet weak var winLossLabel: UILabel!
    
    @IBOutlet weak var tournamentLabel: UILabel!
    @IBOutlet weak var judgeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if the view is empty, automatically transitions to create a debate view.
        if (MainMenuData.debates.isEmpty) {
            
            let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "CreateDebate")
            splitViewController?.showDetailViewController(local, sender: nil)
            
        } else if (debateIndex < MainMenuData.debates.count) {
            let debate = MainMenuData.debates[debateIndex]
            
            titleLabel.text = debate.title
            roundLabel.text = "\(debate.roundNumber ?? 0)"
            opponentLabel.text = debate.otherTeam
            winLossLabel.text = "\(debate.winLoss ?? true)"
            tournamentLabel.text = debate.tournament
            judgeLabel.text = debate.judgeName
            
        } else {
            debateIndex = 0
            viewDidLoad()
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
    
    //transitions back to DebateDetailViewController
    @IBAction func cancel(_ sender: Any) {
        //displays a detailview at index zero of MainMenuData.debates, if empty you are not allowed to leave until a debate is created.
        if (!MainMenuData.debates.isEmpty) {
            
            let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
            splitViewController?.showDetailViewController(local, sender: nil)
        }
    }
    
    
    //creates a new debate using the text fields. Then appends it to the end of the MainMenuData.debates array.
    @IBAction func create(_ sender: Any) {
        
        let localnum = Int(roundField.text ?? "0")
        
        //creates new debate. The unwrapping of optionals is handeled by the Debate class
        let localDebate = Debate(title: titleFIeld.text, roundNumber: localnum, otherTeam: opponentField.text, winLoss: nil, judgeName: judgeField.text, tournament: tournamentField.text)
        
        MainMenuData.debates.append(localDebate)
        
        //This will crash in portrait alignment
        //splitViewController has a navigation view controller that contains our table view controller. We need to navigate to that part of the view hierarchy,
        //then we need to refresh the data assosicated with the tableView. The tableView then rengenerates the table to match MainMenuData.debates
        (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        
        //creates new DebateDetailViewController which displays the last debate in the MainMenuData.debates array.
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
        local.debateIndex = MainMenuData.debates.count - 1
        
        //shows the newly created view.
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

/*
 THe ModifyDebateViewController handles the modification of existing debates. It takes the strings from label and uses them to create a new debate, which remplaces the old debate at index value.
 */
class ModifyDebateViewController: UIViewController {
    
    //index value of target debate. This class assumes that the debateIndex refrancs an currently occupied index in MainMenuData.debates
    var debateIndex:Int = 0
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var roundLabel: UITextField!
    
    @IBOutlet weak var opponentLabel: UITextField!
    
    @IBOutlet weak var judgeLabel: UITextField!

    @IBOutlet weak var tournamentLabel: UITextField!
    
    //When the view is loaded, the old texts for the various properties are loaded. This ensures that only values that the user wants to modify get modfied.
    override func viewDidLoad() {
        super.viewDidLoad()
        let localDebate = MainMenuData.debates[debateIndex]
        titleLabel.text = localDebate.title
        roundLabel.text = "\(localDebate.roundNumber ?? 0)"
        opponentLabel.text = localDebate.otherTeam
        judgeLabel.text = localDebate.judgeName
        tournamentLabel.text = localDebate.tournament
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //returns to DebateView with no modifications performed
    @IBAction func cancel(_ sender: Any) {
        
        //creates a new DebateDetailViewController and then shows that as the new detail view controller
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
        local.debateIndex = debateIndex
        splitViewController?.showDetailViewController(local, sender: nil)
        
    }
    
    //modifies the debate at debateIndex in order to match the values supplied in the textfields.
    @IBAction func modify(_ sender: Any) {
        
        let localInt = Int(roundLabel.text ?? "0")
        
        //The unwrapping of optionals is handled by the debate class
        let localDebate = Debate(title: titleLabel.text, roundNumber: localInt, otherTeam: opponentLabel.text, winLoss: nil, judgeName: judgeLabel.text, tournament: tournamentLabel.text)
        
        //The date created/date to expire are kept the same across modifications
        localDebate.dateCreated = MainMenuData.debates[debateIndex].dateCreated
        localDebate.expirationDate = MainMenuData.debates[debateIndex].expirationDate

        
        MainMenuData.debates[debateIndex] = localDebate
        
        //This will crash in portrait alignment
        //splitViewController has a navigation view controller that contains our table view controller. We need to navigate to that part of the view hierarchy,
        //then we need to refresh the data assosicated with the tableView. The tableView then rengenerates the table to match MainMenuData.debates
        (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        
        //creates a new DebateDetailViewController and then shows that as the new detail view controller
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
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

