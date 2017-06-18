//
//  ViewController.swift
//  TapMe
//
//  Created by Batuhan Kök on 26.05.2015.
//  Copyright (c) 2015 Batuhan Kök. All rights reserved.
//

import UIKit
import AVFoundation

class MainView: UIViewController {

    //Music player settings
    lazy var backgroundMusic: AVAudioPlayer? = {
        guard let url = Bundle.main.url(forResource: "background", withExtension: "mp3") else { return nil }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            return player
        } catch { return nil }
    }()
    
    //User defaults
    let ud = UserDefaults.standard
    
    //Background imageview outlet
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make some changes for design
        gameDesign()
        
        
        //Check music status and do it
        let musicStatus = ud.string(forKey: "musicStatus")
        if musicStatus == ""{
            ud.set(1, forKey: "musicStatus")
        }
        if musicStatus == "0"{
            backgroundMusic?.pause()
        }else{
            backgroundMusic?.play()
        }
            

        //If game level didn't set for now
        if ud.string(forKey: "gameLevel") == nil{
            ud.set("0", forKey: "gameLevel")
        }
        
         
        //If best tap didn't set for now
        if ud.string(forKey: "bestTap") == nil{
            ud.set("", forKey: "bestTap")
        }
        

    }
    

    //When user tapped the best record button
    func bestrecordButtonTapped(){
        
        let bestTap:String = ud.string(forKey: "bestTap")!
        
        if bestTap != "" && bestTap != "0"{
            
            let alertController = UIAlertController(title: "Best Record", message: "Your best record is \(String(describing: bestTap)) times! 👍🏻", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            
            let resetAction = UIAlertAction(title: "Reset", style: UIAlertActionStyle.destructive) {
                (result : UIAlertAction) -> Void in
                
                self.ud.set("", forKey: "bestTap")
                
            }
            
            alertController.addAction(resetAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            
            let alertController = UIAlertController(title: "Best Record", message: "You didn't play the game yet 😞", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }

    }
    
    
    //When user tapped the information button
    func infoButtonTapped(){
        
        let alertController = UIAlertController(title: "Info", message: "The app's developer is Batuhan Kök.", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (result : UIAlertAction) -> Void in
        }
        
        let siteAction = UIAlertAction(title: "Visit My Site", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
                UIApplication.shared.openURL(URL(string: "https://batuhan.me")!)
        }
        
        var title = ""
        let musicStatus = ud.string(forKey: "musicStatus")
        
        if musicStatus == "0"{
            title = "Play the Sound 🔔"
        }else{
            title = "Stop the Sound 🔕"
        }
        
        let soundAction = UIAlertAction(title: title, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            
            if musicStatus == "0"{
                self.backgroundMusic?.play()
                self.ud.set("1", forKey: "musicStatus")
            }else{
                self.backgroundMusic?.pause()
                self.ud.set("0", forKey: "musicStatus")
            }
            
        }
        

        alertController.addAction(siteAction)
        alertController.addAction(soundAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //Option for time 30sec (key: 0)
    @IBAction func easyButtonTapped(_ sender: Any) {
        ud.set("0", forKey: "gameLevel")
    }
    
    
    //Option for time 45sec (key: 1)
    @IBAction func mediumButtonTapped(_ sender: Any) {
        ud.set("1", forKey: "gameLevel")
    }
    
    
    //Option for time 60 (key: 2)
    @IBAction func hardButtonTapped(_ sender: Any) {
        ud.set("2", forKey: "gameLevel")
    }
    
    
    //Play button tapped
    @IBAction func playButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "playTheGame", sender: self)
        
    }
    
    
    //Game's design
    func gameDesign(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: 0xAB7A43)
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 19)!, NSForegroundColorAttributeName: UIColor.white ]
        
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //White statusbar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

