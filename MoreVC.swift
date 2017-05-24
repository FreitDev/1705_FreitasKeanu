//
//  MoreVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/6/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MoreVC: UIViewController {
    
    @IBOutlet var radiusLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutBtnTapped(_ sender: UIBarButtonItem) {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LogInVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = logInVC
    }

    @IBAction func radiusStepper(_ sender: UIStepper) {
        
        let counter = Int(sender.value)
        radiusLbl.text = String("\(counter) mi.")
    }
    
    @IBAction func locationServicesUISwitch(_ sender: UISwitch) {
        
        if sender.isOn == true {
            
            let alertController = UIAlertController (title: "Turn on Location Services.", message: "Go to Settings?", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
                print("cancel pressed.")
                sender.isOn = false
            }
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else if sender.isOn == false {
            
            let alertController = UIAlertController (title: "Turn off Location Services.", message: "Go to Settings?", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
                print("cancel pressed.")
                sender.isOn = true
            }
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
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
