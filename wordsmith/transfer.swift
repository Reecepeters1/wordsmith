//
//  ViewController.swift
//  wordsmith
//
//  Created by KRUEGER, JOHN on 4/5/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class TransferViewController: UIViewController {

    var debateIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (childViewControllers[0] as! FlowVeiw).index = debateIndex
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
