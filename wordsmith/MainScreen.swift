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
public class MainScreen: NSObject {
    
    static var debates:[Debate] = []
    
}

import UIKit

// Sotryboard id == MainScreenTable
//Governs the table that displays the list of debate objects
class MainMenuViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    //The number of debates in the MainMenu array determines the number we want to display.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return MainScreen.debates.count
    }
    
    //Generates a cell, the cell displays the name of the other team as well as the tournament
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let debate = MainScreen.debates[indexPath.row]
        cell.textLabel?.text = debate.otherTeam!.appending(debate.tournament ?? "default")

        return cell
    }
    
    //Updates the detail view to display the debate at the currently selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myDetailView = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "DebateDisplay") as! DebateView
        myDetailView.myDebateIndex = indexPath.row
        myDetailView.refreshUI()
        
        splitViewController?.showDetailViewController(myDetailView, sender: nil )
    }
    
    //indicates the row is in fact editable.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Deletes the debate at the selected index. This function also updates the detail and table views.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if !MainScreen.debates.isEmpty {
                MainScreen.debates.remove(at: indexPath.row)
                tableView.reloadData()
            }
            
            let myDetailView = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "DebateDisplay") as! DebateView
            
            if !MainScreen.debates.isEmpty && indexPath.row < MainScreen.debates.count {
                if indexPath.row == 0 && MainScreen.debates.count >= 2 {
                    myDetailView.myDebateIndex = 1
                    myDetailView.refreshUI()
                    splitViewController?.showDetailViewController(myDetailView, sender: nil )
                    
                } else if MainScreen.debates.isEmpty {
                    //prompt for creation of new debate, because the array is empty
                    myDetailView.performSegue(withIdentifier: "createDebateSegue", sender: nil)
                    
                } else {
                    
                    myDetailView.myDebateIndex = indexPath.row - 1
                    myDetailView.refreshUI()
                    splitViewController?.showDetailViewController(myDetailView, sender: nil )
                    
                }
                
            } else {
                //prompt for creation of new debate, because the array is empty
                myDetailView.performSegue(withIdentifier: "createDebateSegue", sender: nil)
                
            }
        }
    }
    
    
    
    
}

//This is the detail view displayed when preveiwing a debate
class DebateView: UIViewController {
    
    //Contains a refrence to the index value of the Debate Array at the current row
    var myDebateIndex = 0
    
    static var currentIndexToDelete = 0
    
    //Set of properties used to define a Debate. Currently only user defined properties
    @IBOutlet weak var debateTitle: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var tournament: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var judge: UILabel!
    @IBOutlet weak var win: UILabel!
    
    
    //safely deletes a debate, prompts to create new debate if the MainScreen array of Debate objects is empty.
    func deleteDebate() {
        
        if !MainScreen.debates.isEmpty && myDebateIndex < MainScreen.debates.count {
            
            
            MainScreen.debates.remove(at: myDebateIndex)
            
            if  myDebateIndex != 0 {
                myDebateIndex -= 1
                refreshUI()
                
                //Here, viewControllers[0] is the navigation controller that houses the MainMenuViewController. That is why I am access the child.
                (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuViewController).tableView.reloadData()
                
                //let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "MainScreenTable") as! MainMenuViewController
                //local.tableView.reloadData()
                //local.title = "Debates"
                
                ////splitViewController?.navigationController?.show(local, sender: nil)
                //splitViewController?.viewControllers[0] = local
                
            } else if myDebateIndex == 0 && MainScreen.debates.count != 2 {
                myDebateIndex += 1
                refreshUI()
                
                //Here, viewControllers[0] is the navigation controller that houses the MainMenuViewController. That is why I am access the child.
                (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuViewController).tableView.reloadData()
                
                /* Here are a set of other ways dodo above that don't quite work. I'm leaving them here incase they are ever useful
                //let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "MainScreenTable") as! MainMenuViewController
                //local.tableView.reloadData()
                //local.title = "Debates"
                
                //splitViewController?.viewControllers[0] = local
                 */
                
            } } else {
                performSegue(withIdentifier: "createDebateSegue", sender: nil)
            }
            
        
        
    }
    
    /* So, you hit the delete button. It asks the user for confirmation then deletes the debate currently refrenced in myDebateIndex */
    @IBAction func deleteDebateButton(_ sender: Any)
    {
        
        deleteDebate()
    }
    
    @IBAction func modifyDebate(_ sender: Any) {
    }
    
    @IBAction func createDebateButton(_ sender: Any) {
        performSegue(withIdentifier: "createDebateSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Okay, so, this updates all the properties to reflect the new index value. It loads the view if needed.
    func refreshUI() {
        
        loadViewIfNeeded()
        
        if MainScreen.debates.isEmpty {
            performSegue(withIdentifier: "createDebateSegue", sender: nil)
        }
        
        if !MainScreen.debates.isEmpty && myDebateIndex < MainScreen.debates.count {
            let debate = MainScreen.debates[myDebateIndex]
        
            teamName.text = debate.otherTeam ?? "otherPeople"
            debateTitle.text = debate.title!
            tournament.text = debate.tournament ?? "default"
            round.text = String(describing: debate.roundNumber)
            judge.text = debate.judgeName
        
            if debate.winLoss == nil {
                win.text = "Unkown"
            } else if debate.winLoss! {
                win.text = "Win"
            } else {
            win.text = "False"
            }
        } else {
            print("You done tried to display an index value that doesn't exist! What are you even doing with your life!")
        }
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

//Storyboard ID = CreateDebate
//This class controls the creation of new debates - duh.
class CreateDebateView: UIViewController {
    
    var isNew = false
    
    @IBOutlet weak var debatetitle: UITextField!
    
    @IBOutlet weak var team: UITextField!
    
    @IBOutlet weak var tournament: UITextField!
    
    @IBOutlet weak var round: UITextField!
    
    @IBOutlet weak var judge: UITextField!
    
    override func viewDidLoad() {
        
        debatetitle.placeholder = "Title"
        team.placeholder = "Team"
        tournament.placeholder = "tournament"
        round.placeholder = "round"
        judge.placeholder = "Judge"
        
    }
    
    //The segue happens regardless of this function, this is here in case I need to add aything that happens when canceled is pressed.
    @IBAction func cancel(_ sender: Any) {
        
        
    }
    
    //This functions creates a Debate using the user supplied text, then adds it to the MainScreen array of Debate objects.
    @IBAction func create(_ sender: Any) {
        let mydebate = debatetitle.text ?? "The Devil VS J.C Webster"
        let myteam = team.text ?? "Molach"
        let mytournament = tournament.text ?? "The Center of the Mind"
        let myround =  Int(round!.text!) ?? 666
        let myjudge = judge.text ?? "Thy Self"
        
        let local = Debate(title: mydebate, roundNumber: myround, otherTeam: myteam, judgeName: myjudge)
        
        MainScreen.debates.append(local)
        
        splitViewController?.viewControllers[0].childViewControllers[0].viewDidLoad()
        
        let newView = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "DebateDisplay") as! DebateView
        
        newView.myDebateIndex = MainScreen.debates.count - 1
        
        splitViewController?.showDetailViewController(newView, sender: nil)
        
        //performSegue(withIdentifier: "cancelDebateSegue", sender: nil)
        
        
    }
    
    
}


