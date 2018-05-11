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
    
    @IBOutlet weak var tournament: UILabel!
    
    var debateIndex:Int = 0
    var localDebate:Debate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debateIndex = MainMenuData.index
        localDebate = MainMenuData.debates[debateIndex]
        // Do any additional setup after loading the view.
        renderText()
    }
    
    func renderText() {
        tournament.text = localDebate!.tournament
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func launch(_ sender: UIButton) {
        MainMenuData.index = debateIndex
        performSegue(withIdentifier: "pushToFlow", sender: self)
    }
    
    @IBAction func modify(_ sender: UIButton) {
        MainMenuData.index = debateIndex
        performSegue(withIdentifier: "toModifyDebate", sender: self)
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
extension DebateDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localDebate?.judgeNames.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayCell") as! DisplayTableCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension DebateDetailViewController: UITableViewDelegate {
    // extension implementation
}

class DisplayTableCell: UITableViewCell {
    
    @IBOutlet weak var vote: UIView!
    
    @IBOutlet weak var judgeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CreateDebateViewController: UIViewController {
    
    var forceStay = false
    var judgeTextAr = ["Default"]
    var index = 0
    
    @IBOutlet weak var judgesTable: UITableView!
    @IBOutlet weak var tournament: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (forceStay == false && !MainMenuData.debates.isEmpty) {
            performSegue(withIdentifier: "toDebateDetail", sender: self)
        }
        judgesTable.dataSource = self
        judgesTable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    //Adds cell to table with judge field
    @IBAction func addJudge(_ sender: UIButton) {
        judgeTextAr.append("Default")
        judgesTable.reloadData()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        performSegue(withIdentifier: "toDebateDetail", sender: self)
    }
    
    @IBAction func create(_ sender: UIButton) {
        let debate = Debate(ballot: nil, round: nil, otherTeam: nil, judgeName: [nil], tournament: tournament.text, side: nil)
        MainMenuData.debates.append(debate)
        MainMenuData.index = MainMenuData.debates.count - 1
        performSegue(withIdentifier: "toDebateDetail", sender: self)
    }
}
extension CreateDebateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return judgeTextAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JudgeCell") as! JudgeCellTableViewCell
        if (judgeTextAr[indexPath.row] == "Default") {
            cell.judgeField.placeholder = "Judge Name Here"
        } else {
            cell.judgeField.text = judgeTextAr[indexPath.row]
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        index = indexPath.row
    }
    
    func textFieldShouldEndEditing(field: UITextField) {
        judgeTextAr[index] = field.text ?? "Default"
        print(judgeTextAr)
    }
}
extension CreateDebateViewController: UITableViewDelegate {
    // extension implementation
}
extension CreateDebateViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
}

extension CreateDebateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("\(row)")
        return "\(row)"
    }
}


class JudgeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var judgeField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}




/*
 THe ModifyDebateViewController handles the modification of existing debates. It takes the strings from label and uses them to create a new debate, which remplaces the old debate at index value.
 */
class ModifyDebateViewController: UIViewController {
    
    //index value of target debate. This class assumes that the debateIndex refrancs an currently occupied index in MainMenuData.debates
    var debateIndex:Int = 0
    
    
    //When the view is loaded, the old texts for the various properties are loaded. This ensures that only values that the user wants to modify get modfied.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueToDebateDetail() {
        performSegue(withIdentifier: "toDebateDetail", sender: self)
    }
    
    @IBAction func modify(_ sender: Any) {
        
        //let localInt = Int(roundLabel.text ?? "0")
        
        //The unwrapping of optionals is handled by the debate class
        //let localDebate = Debate(ballot: nil, round: nil, otherTeam: nil, judgeName: [nil], tournament: nil)
        
        //The date created/date to expire are kept the same across modifications
        //localDebate.dateCreated = MainMenuData.debates[debateIndex].dateCreated
        //localDebate.expirationDate = MainMenuData.debates[debateIndex].expirationDate

        
        //MainMenuData.debates[debateIndex] = localDebate
        
        //This will crash in portrait alignment
        //splitViewController has a navigation view controller that contains our table view controller. We need to navigate to that part of the view hierarchy,
        //then we need to refresh the data assosicated with the tableView. The tableView then rengenerates the table to match MainMenuData.debates
        
        (splitViewController?.viewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        
        
        //creates a new DebateDetailViewController and then shows that as the new detail view controller
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
        local.debateIndex = debateIndex
        splitViewController?.showDetailViewController(local, sender: nil)
        
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        segueToDebateDetail()
    }
    //returns to DebateView with no modifications performed
  
    
}

