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
    
    func amountofcardsinflow(debate:Int, flow:Int) {
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
        
        var localString = MainMenuData.debates[indexPath.row].tournament
        localString.append(" ")
        localString.append(MainMenuData.debates[indexPath.row].getRound())
        
        cell.textLabel?.text? = localString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Showing a new DebateDetailView after selecting a row")
        var local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "debateView") as! DebateDetailViewController
        print(indexPath.row)
        MainMenuData.index = indexPath.row
        local.debateIndex = indexPath.row
        local.localDebate = MainMenuData.debates[local.debateIndex]
        
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
            MainMenuData.index = temp
            local.debateIndex = temp
            local.localDebate = MainMenuData.debates[local.debateIndex]
            splitViewController?.showDetailViewController(local, sender: nil)
            
        }
    }
    
    @IBAction func createDebate(_ sender: UIBarButtonItem) {
        let local = AppStoryboard.MainMenu.instance.instantiateViewController(withIdentifier: "CreateDebate") as! CreateDebateViewController
        local.forceStay = true
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
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var ballotLabel: UILabel!
    @IBOutlet weak var opponentLabel: UILabel!
    
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
        roundLabel.text = localDebate!.getRound()
        sideLabel.text = localDebate!.getSide()
        opponentLabel.text = localDebate!.otherTeam
        ballotLabel.text = localDebate!.getWinLoss()
        
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
    
    @IBAction func deleteDebate(_ sender: Any) {
        MainMenuData.debates.remove(at: debateIndex)
        
        if (MainMenuData.debates.isEmpty) {
            performSegue(withIdentifier: "showCreateDebate", sender: self)
            (splitViewController?.childViewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        } else if (debateIndex == 0) {
            debateIndex += 1
            localDebate = MainMenuData.debates[debateIndex]
            MainMenuData.index = debateIndex
            renderText()
            (splitViewController?.childViewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
        } else {
            debateIndex -= 1
            localDebate = MainMenuData.debates[debateIndex]
            MainMenuData.index = debateIndex
            renderText()
            (splitViewController?.childViewControllers[0].childViewControllers[0] as! MainMenuTableViewController).tableView.reloadData()
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
extension DebateDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localDebate?.judgeNames.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayCell") as! DisplayTableCell
        cell.judgeName.text = localDebate?.judgeNames[indexPath.row].name
        cell.vote.text = localDebate?.voteToString(judge: (localDebate?.judgeNames[indexPath.row])!)
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
    
    @IBOutlet weak var vote: UILabel!
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

protocol WHYISSIWFTSOAFWUL: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool
}

class CreateDebateViewController: UIViewController {
    
    var forceStay = false
    var judgeTextAr = ["Default"]
    var index = 0
    @IBOutlet weak var elimSwitch: UISwitch!
    @IBOutlet weak var roundTextField: UITextField!
    @IBOutlet weak var sideSwitch: UISwitch!
    @IBOutlet weak var opponentField: UITextField!
    
    func remove() -> Any {
        func removeCell (myIndex: Int) -> () {
            print("I was invoked")
            
            self.saveTextToAr()
            
            self.judgeTextAr.remove(at: myIndex)
            
            self.judgesTable.reloadData()
        }
        return removeCell
    }
    
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
        saveTextToAr()
        
        judgeTextAr.append("Default")
        
        judgesTable.reloadData()
    }
    
    func saveTextToAr(){
        
        if (!judgeTextAr.isEmpty){
            for temp in 0...judgeTextAr.count - 1 {
                let myIndexPath = IndexPath(row: temp, section: 0)
                let cell = judgesTable.cellForRow(at: myIndexPath)
                
                if cell != nil {
                    //found nil when this cell off screen
                    judgeTextAr[temp] = ((cell ?? JudgeCellTableViewCell()) as! JudgeCellTableViewCell).judgeField.text ?? "Default"
                }
            }
        } else {
            return
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        performSegue(withIdentifier: "toDebateDetail", sender: self)
    }
    
    @IBAction func create(_ sender: UIButton) {
        
        saveTextToAr()
        var myRound = Debate.Round()
        myRound.isElim = elimSwitch.isOn
        
        if (myRound.isElim) {
            myRound.elim = roundTextField.text
        } else {
            myRound.number = Int(roundTextField.text ?? "0")
        }
        
        var mySide:Debate.Side
        if (sideSwitch.isOn) {
            mySide = Debate.Side.aff
        } else {
            mySide = Debate.Side.neg
        }
        
        let debate = Debate(ballot: nil, round: myRound, otherTeam: opponentField.text, judgeName: judgeTextAr, tournament: tournament.text, side: mySide)
        MainMenuData.debates.append(debate)
        MainMenuData.index = MainMenuData.debates.count - 1
        
        //(splitViewController?.childViewControllers[0].childViewControllers as! MainMenuTableViewController).tableView.reloadData()
        let x = splitViewController!.viewControllers[0]
        let y = x.childViewControllers[0] as! MainMenuTableViewController
        y.tableView.reloadData()
        performSegue(withIdentifier: "toDebateDetail", sender: self)
    }
    
}
extension CreateDebateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return judgeTextAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JudgeCell") as! JudgeCellTableViewCell
        
        cell.judgeField.delegate = self
        cell.judgeField.index = indexPath.row
        cell.currentIndex = indexPath.row
        cell.deleteJudgeClosure = remove() as! ((Int) -> Void)
        //(cell.contentView as! JudgeContentView).myDeleteFunc = (remove() as! ((_ myIndex: Int) -> ()))
        cell.contentView.isUserInteractionEnabled = true
        //(cell.contentView as! JudgeContentView).myIndex = indexPath.row
        cell.selectionStyle = .none
        
        if (judgeTextAr[indexPath.row] == "Default") {
            cell.judgeField.placeholder = "Judge Name Here"
            cell.judgeField.text = ""
        } else {
            
            cell.judgeField.text = judgeTextAr[indexPath.row]
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        print(index)
    }
    
}
extension CreateDebateViewController: UITableViewDelegate {
    // extension implementation
}
extension CreateDebateViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        if (index < judgeTextAr.count - 1 && (textField as! myDelegatedTextField).index < judgeTextAr.count - 1) {
            judgeTextAr[(textField as! myDelegatedTextField).index] = textField.text ?? "Default"
            print(judgeTextAr)
            return true
        }
        return false
    }
    
    
    
}



class JudgeCellTableViewCell: UITableViewCell {
    
    
    var sittingString: String? = ""
    var currentIndex: Int = 0
    var delegate: Any? = nil
    @IBOutlet weak var judgeField: myDelegatedTextField!
    var deleteJudgeClosure: ((Int) -> Void)?
    @IBAction func deleteJudge(_ sender: Any) {
        
        print("Trying to invoke Function")
        deleteJudgeClosure!(currentIndex)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setDefaults(){
        
    }
    
}




class myDelegatedTextField: UITextField {
    var index = 0
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

