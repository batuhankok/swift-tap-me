//
//  ViewController.swift
//  TapMe
//
//  Created by Batuhan Kök on 26.05.2015.
//  Copyright (c) 2015 Batuhan Kök. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    let ud = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationBarDesign()
        ud.set("0", forKey: "gameLevel")
        
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
    
    @IBAction func easyButtonTapped(_ sender: Any) {
        
        //0 for easy
        ud.set("0", forKey: "gameLevel")
        
    }
    
    @IBAction func mediumButtonTapped(_ sender: Any) {
        
        //1 for medium
        ud.set("1", forKey: "gameLevel")
        
    }
    
    @IBAction func hardButtonTapped(_ sender: Any) {
        
        //2 for hard
        ud.set("2", forKey: "gameLevel")
        
    }
    
    
    //Navigation bar's design
    func navigationBarDesign(){
        
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

