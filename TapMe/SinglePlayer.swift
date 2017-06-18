//
//  SinglePlayer.swift
//  TapMe
//
//  Created by Batuhan Kök on 28.05.2015.
//  Copyright (c) 2015 Batuhan Kök. All rights reserved.
//

import UIKit

class SinglePlayer: UIViewController {
    
    //User defaults
    let ud = UserDefaults.standard
    
    //Outlets
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var tapButton: UIButton!
    
    //Player ini score, remaining time, timer
    var playerScore = 0
    var gameSetupSecond = 0
    var gameSetupTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup the game
        gameSetup()
        
        //Background pattern
        self.bgImageView.image = UIImage(named: "bg")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Tapped!
    @IBAction func tapButtonTapped(_ sender: Any) {
        
        if playerScore % 2 == 0{
            tapButton.setImage(UIImage(named: "tapEven"), for: .normal)
        }else{
            tapButton.setImage(UIImage(named: "tapOdd"), for: .normal)
        }
        
        playerScore += 1
        scoreButton.setTitle("Score: \(playerScore)", for: .normal)
        
    }
    
    
    //When user is gameover
    func gameOver(){
        
        ud.set("\(playerScore)", forKey: "bestTap")
            
        var ifitisnew:String = ""
            
        if let getBestTap = ud.string(forKey: "bestTap"){
            if getBestTap != ""{
                    
                if Int(getBestTap)! < playerScore {
                        
                    ifitisnew = "\nThis is your new best also 🎉"
                        
                }
                
            }
        }
            
        let alertController = UIAlertController(title: "Game Over!", message: "Congarts!\nYou have tapped \(playerScore) times 👏\(ifitisnew)", preferredStyle: UIAlertControllerStyle.alert)
            
        let okAction = UIAlertAction(title: "Return to Home", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
                
            self.dismiss(animated: true, completion: nil)
                
        }
            
        alertController.addAction(okAction)
            
        //If user is on the SinglePlayer view, then alert will be appeared
        if let topController = UIApplication.topViewController() {
            if topController.className == "SinglePlayer"{
                self.present(alertController, animated: true, completion: nil)
            }
        }
   

    }
    
    
    //Setup the game
    func gameSetup(){
        
        if let getGameLevel = ud.string(forKey: "gameLevel"){
            
            if getGameLevel == "0"{
                gameSetupSecond = 60
            }else if getGameLevel == "1"{
                gameSetupSecond = 45
            }else{
                gameSetupSecond = 30
            }
            
        }else{
            gameSetupSecond = 30
        }
        
        scoreButton.setTitle("Score: \(playerScore)", for: .normal)
        timeButton.setTitle("Time: \(gameSetupSecond)s", for: .normal)
        
        gameSetupTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SinglePlayer.gameSetupCounter), userInfo: nil, repeats: true)
        
    }
    
    
    //Check did game is finish and second--
    func gameSetupCounter() {

        if gameSetupSecond == 0{
            gameSetupTimer.invalidate()
            gameOver()
        }else{
            gameSetupSecond -= 1
            timeButton.setTitle("Time: \(gameSetupSecond)s", for: .normal)
        }
        
    }
    
    
    //For turning back to home
    @IBAction func homeButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    
    //Hidden statusbar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //When view closed
    override func viewDidDisappear(_ animated: Bool) {
        gameOver()
        playerScore = 0
        tapButton.isEnabled = false
    }


}
