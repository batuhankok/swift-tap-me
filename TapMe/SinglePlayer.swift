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
    var gameSetupTimer = Timer()
    
    var startingSecond = 0
    var startingTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        startingSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retryButton(_ sender: AnyObject) {
        
        gameOverRetryButton.isHidden = true
        gameOverScoreLabel.isHidden = true
        gameOverMenuButton.isHidden = true
        
        startingTimeLabel.isHidden = false
        
        tapmeHeader.text = "Tap Me!"
        
        startingSetup()
        
    }
    
    @IBAction func tapingPlusOne(_ sender: AnyObject) {
        
        playerScore += 1
        gameSetupScoreLabel.text = "Score: \(playerScore)"
        
    }
    
    func gameOver(){
        
        tapmeHeader.text = "Game Over!"
        
        gameSetupTimeLabel.isHidden = true
        gameSetupScoreLabel.isHidden = true
        tapHereButton.isHidden = true
        
        gameOverRetryButton.isHidden = false
        gameOverMenuButton.isHidden = false
        
        gameOverScoreLabel.isHidden = false
        gameOverScoreLabel.text = "Your Score: \(playerScore)"
        
        let saveLastScore = UserDefaults.standard
        saveLastScore.set("\(playerScore)", forKey: "lastScore")
        playerScore = 0
        
    }
    
    func gameSetup(){
        
        gameSetupTimeLabel.isHidden = false
        gameSetupScoreLabel.isHidden = false
        tapHereButton.isHidden = false
        
        gameSetupScoreLabel.text = "Score: \(playerScore)"
        
        gameSetupSecond = 10
        
        gameSetupTimeLabel.text = "Time: \(gameSetupSecond)"
        
        gameSetupTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SinglePlayer.gameSetupCounter), userInfo: nil, repeats: true)
        
    }
    
    func gameSetupCounter() {
        
        gameSetupSecond -= 1
        gameSetupTimeLabel.text = "Time: \(gameSetupSecond)"
        
        if(gameSetupSecond == 0){
            
            gameSetupTimer.invalidate()
            gameOver()
            
        }
        
    }
    
    func startingSetup(){
        
        startingSecond = 3
        
        startingTimeLabel.text = "\(startingSecond)"
        
        startingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SinglePlayer.startingCounter), userInfo: nil, repeats: true)
        
    }
    
    func startingCounter() {
        
        startingSecond -= 1
        startingTimeLabel.text = "\(startingSecond)"
        
        if(startingSecond == 0){
            
            startingTimer.invalidate()
            startingTimeLabel.isHidden = true
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
