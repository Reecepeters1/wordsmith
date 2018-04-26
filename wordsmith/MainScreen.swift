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
    
    public static var debates:[Debate] = []
    public static var index: Int = 0
    public static var hasDefault: Bool = false
    
    func amountofcardsinflow(debate:Int, flow:Int){
    //tbd l8ter to streamine some functionality for not not needed freddy 4/22
    }
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
        
        print("Showing a new DebateDetailView after selecting a row")
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
        print(indexPath.row)
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
            
            if (MainMenuData.debates.isEmpty) {
                let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "CreateDebate") as! CreateDebateViewController
                splitViewController?.showDetailViewController(local, sender: nil)
            }
            
            print("Showing new DebateDetailViewController do to deletion")
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
    
    @IBOutlet weak var popUp: UIView!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var opponentLabel: UILabel!
    
    @IBOutlet weak var winLossLabel: UILabel!
    
    @IBOutlet weak var tournamentLabel: UILabel!
    @IBOutlet weak var judgeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View didLoad started")
        //if the view is empty, automatically transitions to create a debate view.
        
        //hides the popup that appears when one tries to delete a Debate
        popUp.isHidden = true
        
        
        if (MainMenuData.hasDefault) {
            print("Doing Startup")
        
            roundLabel.text = "\(MainMenuData.debates[debateIndex].roundNumber ?? 0)"
            
            opponentLabel.text = MainMenuData.debates[debateIndex].otherTeam
            
            winLossLabel.text = "\(MainMenuData.debates[debateIndex].winLoss ?? true)"
            
            tournamentLabel.text = MainMenuData.debates[debateIndex].tournament
            
            judgeLabel.text = MainMenuData.debates[debateIndex].judgeName
            
            let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "CreateDebate") as! CreateDebateViewController
            splitViewController?.showDetailViewController(local, sender: nil)
            
        } else if (debateIndex < MainMenuData.debates.count && debateIndex >= 0) {
            
            print("trying to show debate")
            
            //debate = MainMenuData.debates[ debateIndex ]
            
            print("The debate has a judge of \(MainMenuData.debates[ debateIndex ].judgeName)" )
            
            roundLabel.text = "\(MainMenuData.debates[ debateIndex ].roundNumber ?? 0)"
            
            opponentLabel.text = MainMenuData.debates[ debateIndex ].otherTeam
            
            winLossLabel.text = "\(MainMenuData.debates[ debateIndex ].winLoss ?? true)"

            tournamentLabel.text = MainMenuData.debates[ debateIndex ].tournament
            
            judgeLabel.text = MainMenuData.debates[ debateIndex ].judgeName
            
            print("The judge label text is \(judgeLabel.text!)")
            
            view.setNeedsDisplay()
            
            //return
            
        } else {
            print("recursive call to ViewDidload at Index zero")
            debateIndex = 0
            viewDidLoad()
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //The launch button transitions to the set of views used to display Debate rounds.
    @IBAction func launch(_ sender: Any) {
        print("Starting Launch")
        print("starting transfer")
        
        MainMenuData.index = self.debateIndex
        //This creates a copy of the TrasferViewController, then pushes that into the root view of the splitViewController.
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "masterView") as! TransferViewController
        
        //This index is used to track the debate that ought to be accessed. 
        local.debateIndex = debateIndex
        performSegue(withIdentifier: "pushToFlow", sender: nil)
        //print("Transfer Complete")
    }
    
    //Shows the ModifyDebateView which enables modification of the Debate at the current index
    @IBAction func modify(_ sender: Any) {
        print("Starting Modify")
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "ModifyDebate") as! ModifyDebateViewController
        local.debateIndex = debateIndex
        splitViewController?.showDetailViewController(local, sender: nil)
        
    }
    
    //When a user hits the delete button, this shows the popUp view
    @IBAction func deleteOpenPopUp(_ sender: Any) {
        popUp.isHidden = false
    }
    
    //Hides the popUp view if the user cancels
    @IBAction func cancelDeletion(_ sender: Any) {
        popUp.isHidden = true
    }
    
    //This function assumes that the current Debate Index is a valid index.
    //It deletes the debate at the current Index
    @IBAction func deleteCurrentDebate(_ sender: Any) {
        
        MainMenuData.debates.remove(at: debateIndex)
        
        (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        
        debateIndex -= 1
        
        viewDidLoad()
        
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
        if (!MainMenuData.hasDefault) {
            let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
            splitViewController?.showDetailViewController(local, sender: nil)
        } else {
            print("Attempting to leave CreateDebate view before any Debates have been created in MainMenuData.debates")
        }
    }
    
    
    //creates a new debate using the text fields. Then appends it to the end of the MainMenuData.debates array.
    @IBAction func create(_ sender: Any) {
        
        let localnum = Int(roundField.text ?? "0")
        
        //creates new debate. The unwrapping of optionals is handeled by the Debate class
        //let localDebate = Debate( roundNumber: localnum, otherTeam: opponentField.text, winLoss: nil, judgeName: judgeField.text, tournament: tournamentField.text)
        
        //MainMenuData.debates.append(localDebate)
        
        //checks to see if there is a default debate at index zero. If there is, it is deleted and hasDefault is set to false.
        if (MainMenuData.hasDefault) {
            MainMenuData.debates.remove(at: 0)
            MainMenuData.hasDefault = false
        }
        
        //This will crash in portrait alignment
        //splitViewController has a navigation view controller that contains our table view controller. We need to navigate to that part of the view hierarchy,
        //then we need to refresh the data assosicated with the tableView. The tableView then rengenerates the table to match MainMenuData.debates
        (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        
        //creates new DebateDetailViewController which displays the last debate in the MainMenuData.debates array.
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
        
        
        
        local.debateIndex = MainMenuData.debates.count - 1
        
        print(local.debateIndex)
        
        print(MainMenuData.debates.last!.judgeName)
        local.view.setNeedsDisplay()
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
    
    
    @IBOutlet weak var roundLabel: UITextField!
    
    @IBOutlet weak var opponentLabel: UITextField!

    @IBOutlet weak var tournamentLabel: UITextField!
    
    //When the view is loaded, the old texts for the various properties are loaded. This ensures that only values that the user wants to modify get modfied.
    override func viewDidLoad() {
        super.viewDidLoad()
        let localDebate = MainMenuData.debates[debateIndex]
        roundLabel.text = "\(localDebate.roundNumber ?? 0)"
        opponentLabel.text = localDebate.otherTeam
        //judgeLabel.text = localDebate.judgeName
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
        let localDebate = Debate(roundNumber: localInt, otherTeam: opponentLabel.text, winLoss: nil, judgeName: nil, judgeNumber: 1, tournament: tournamentLabel.text)
        
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

