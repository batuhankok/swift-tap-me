//
//  SinglePlayer.swift
//  TapMe
//
//  Created by Batuhan Kök on 28.05.2015.
//  Copyright (c) 2015 Batuhan Kök. All rights reserved.
//

import UIKit

class SinglePlayer: UIViewController {
    
    @IBOutlet weak var startingTimeLabel: UILabel!
    @IBOutlet weak var gameSetupTimeLabel: UILabel!
    @IBOutlet weak var tapmeHeader: UILabel!
    @IBOutlet weak var gameSetupScoreLabel: UILabel!
    @IBOutlet weak var tapHereButton: UIButton!
    @IBOutlet weak var gameOverMenuButton: UIButton!
    @IBOutlet weak var gameOverRetryButton: UIButton!
    @IBOutlet weak var gameOverScoreLabel: UILabel!
    
    var playerScore = 0
    
    var gameSetupSecond = 0
    var gameSetupTimer = NSTimer()
    
    var startingSecond = 0
    var startingTimer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()

        startingSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retryButton(sender: AnyObject) {
        
        gameOverRetryButton.hidden = true
        gameOverScoreLabel.hidden = true
        gameOverMenuButton.hidden = true
        
        startingTimeLabel.hidden = false
        
        tapmeHeader.text = "Tap Me!"
        
        startingSetup()
        
    }
    
    @IBAction func tapingPlusOne(sender: AnyObject) {
        
        playerScore++
        gameSetupScoreLabel.text = "Score: \(playerScore)"
        
    }
    
    func gameOver(){
        
        tapmeHeader.text = "Game Over!"
        
        gameSetupTimeLabel.hidden = true
        gameSetupScoreLabel.hidden = true
        tapHereButton.hidden = true
        
        gameOverRetryButton.hidden = false
        gameOverMenuButton.hidden = false
        
        gameOverScoreLabel.hidden = false
        gameOverScoreLabel.text = "Your Score: \(playerScore)"
        
        let saveLastScore = NSUserDefaults.standardUserDefaults()
        saveLastScore.setObject("\(playerScore)", forKey: "lastScore")
        
    }
    
    func gameSetup(){
        
        gameSetupTimeLabel.hidden = false
        gameSetupScoreLabel.hidden = false
        tapHereButton.hidden = false
        
        gameSetupScoreLabel.text = "Score: \(playerScore)"
        
        gameSetupSecond = 10
        
        gameSetupTimeLabel.text = "Time: \(gameSetupSecond)"
        
        gameSetupTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("gameSetupCounter"), userInfo: nil, repeats: true)
        
    }
    
    func gameSetupCounter() {
        
        gameSetupSecond--
        gameSetupTimeLabel.text = "Time: \(gameSetupSecond)"
        
        if(gameSetupSecond == 0){
            
            gameSetupTimer.invalidate()
            gameOver()
            
        }
        
    }
    
    func startingSetup(){
        
        startingSecond = 3
        
        startingTimeLabel.text = "\(startingSecond)"
        
        startingTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("startingCounter"), userInfo: nil, repeats: true)
        
    }
    
    func startingCounter() {
        
        startingSecond--
        startingTimeLabel.text = "\(startingSecond)"
        
        if(startingSecond == 0){
            
            startingTimer.invalidate()
            startingTimeLabel.hidden = true
            gameSetup()

        }
        
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
