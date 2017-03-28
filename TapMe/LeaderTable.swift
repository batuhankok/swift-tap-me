//
//  LeaderTable.swift
//  TapMe
//
//  Created by Batuhan Kök on 28.05.2015.
//  Copyright (c) 2015 Batuhan Kök. All rights reserved.
//

import UIKit

class LeaderTable: UIViewController {

    @IBOutlet weak var lastScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fetchLastScore = UserDefaults.standard
        if let lastScore = fetchLastScore.string(forKey: "lastScore")
        {
            
            lastScoreLabel.text = lastScore
            
        }else{
            
            lastScoreLabel.text = "0"
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
