//
//  MainScreen.swift
//  wordsmith/Users/802781/Documents/wordsmith/wordsmith/MainScreen.swift
//
//  Created by KRUEGER, JOHN on 1/24/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import os.log

public class MainScreen: NSObject {
    
    static var debates:[Debate] = []
    
}

import UIKit

class MainMenuViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return MainScreen.debates.count
        return MainScreen.debates.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let debate = MainScreen.debates[indexPath.row]
        cell.textLabel?.text = debate.otherTeam!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myDetailView = storyboard?.instantiateViewController(withIdentifier: "DebateDisplay") as! DebateView
        myDetailView.myDebateIndex = indexPath.row
        myDetailView.refreshUI()
        splitViewController?.showDetailViewController(myDetailView, sender: nil )
    }
    
    
    
    
}


class DebateView: UIViewController {
    
    //Whenever this property is modified, the properties refresh
    //Contains a refrence to the index value of the Debate Array at the current row
    var myDebateIndex = 0 {
        didSet {
            refreshUI()
        }
    }
    
    //Set of properties used to define a Debate. Currently only user defined properties
    @IBOutlet weak var debateTitle: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var tournament: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var judge: UILabel!
    @IBOutlet weak var win: UILabel!
    
    
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
        
        let debate = MainScreen.debates[myDebateIndex]
        
        teamName.text = debate.otherTeam!
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

