//
//  SinglePlayer.swift
//  TapMe
//
//  Created by Batuhan Kök on 28.05.2015.
//  Copyright (c) 2015 Batuhan Kök. All rights reserved.
//

import UIKit

class SinglePlayer: UIViewController {
    
    let ud = UserDefaults.standard
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    var playerScore = 0
    var gameSetupSecond = 0
    var gameSetupTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        gameSetup()
        gameDesign()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tapButtonTapped(_ sender: Any) {
        
        if playerScore % 2 == 0{
            tapButton.setImage(UIImage(named: "tapEven"), for: .normal)
        }else{
            tapButton.setImage(UIImage(named: "tapOdd"), for: .normal)
        }
        
        playerScore += 1
        scoreButton.setTitle("Score: \(playerScore)", for: .normal)
        
    }
    
    
    func gameOver(){
        
        
        var ifitisnew:String = ""
        
        if let getBestTap = ud.string(forKey: "bestTap"){
            
            if Int(getBestTap)! < playerScore {
                
                ud.set("\(playerScore)", forKey: "bestTap")
                ifitisnew = "\nThis is your new best also!"
                
            }
            
        }
        
        let alertController = UIAlertController(title: "Game Over!", message: "Congarts!\nYou have tapped \(playerScore) times.\(ifitisnew)", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Return to Home", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as? MainView {
                if let navigator = self.navigationController {
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                    navigator.pushViewController(viewController, animated: true)
                        
                    })
                    
                }
            }
            
        }
        
        alertController.addAction(okAction)
        
        //If user is on the SinglePlayer view, then alert will be appeared
        if let topController = UIApplication.topViewController() {
            if topController.className == "SinglePlayer"{
                self.present(alertController, animated: true, completion: nil)
            }
        }

        playerScore = 0
        
    }
    
    func gameSetup(){
        
        if let getGameLevel = ud.string(forKey: "gameLevel"){
            
            if getGameLevel == "0"{
                gameSetupSecond = 45
            }else if getGameLevel == "1"{
                gameSetupSecond = 30
            }else{
                gameSetupSecond = 20
            }
            
        }else{
            gameSetupSecond = 45
        }
        
        scoreButton.setTitle("Score: \(playerScore)", for: .normal)
        timeButton.setTitle("Time: \(gameSetupSecond)s", for: .normal)
        
        gameSetupTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SinglePlayer.gameSetupCounter), userInfo: nil, repeats: true)
        
    }
    
    func gameSetupCounter() {
        
        gameSetupSecond -= 1
        timeButton.setTitle("Time: \(gameSetupSecond)s", for: .normal)
        
        if(gameSetupSecond == 0){
            gameOver()
        }
        
    }
    
    
    func bestrecordButtonTapped(){
        
        var bestTap:String = ""
        
        if let getBestTap = ud.string(forKey: "bestTap"){
            bestTap = getBestTap
        }else{
            ud.set("", forKey: "bestTap")
        }
        
        if bestTap != ""{
            
            let alertController = UIAlertController(title: "Best Record", message: "Your best record is \(bestTap) times tapped!", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            
            let alertController = UIAlertController(title: "Best Record", message: "You didn't play the game yet :(", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func infoButtonTapped(){
        
        let alertController = UIAlertController(title: "Developer", message: "Batuhan Kök\nhttps://batuhan.me", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        
        let okAction = UIAlertAction(title: "See the Site", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            UIApplication.shared.openURL(URL(string: "https://batuhan.me")!)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //White statusbar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //When view closed
    override func viewDidDisappear(_ animated: Bool) {
        gameOver()
    }
    
    
    //Music button
    @IBAction func musicButtonTapped(_ sender: Any) {

        musicButton.setImage(UIImage(named: "musicOff"), for: .normal)
      
    }
    
    
    //Game's design
    func gameDesign(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: 0xAB7A43)
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 18)!, NSForegroundColorAttributeName: UIColor.white ]
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "info"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "bestrecord"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(bestrecordButtonTapped), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButton(item1, animated: true)
        self.navigationItem.setLeftBarButton(item2, animated: true)
        
        self.bgImageView.image = UIImage(named: "bg")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }


}
