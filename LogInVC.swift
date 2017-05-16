//
//  LogInVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/4/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class LogInVC: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(FBSDKAccessToken.current() != nil){
            // logged in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyBoard.instantiateViewController(withIdentifier: "tabBarNav") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
            tabBarController.selectedIndex = 2
            
        }else{
            // Not logged in
        }
        
        let logInBtn = FBSDKLoginButton()
        view.addSubview(logInBtn)
        logInBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontal = NSLayoutConstraint(item: logInBtn, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0.0)
        let vertical = NSLayoutConstraint(item: logInBtn, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.5, constant: 0.0)
        let width = NSLayoutConstraint(item: logInBtn, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0.0)
        let height = NSLayoutConstraint(item: logInBtn, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.05, constant: 0.0)
        
        view.addConstraints([horizontal, vertical, width, height])
        logInBtn.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        print("Did log out of Facebook.")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LogInVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = logInVC
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    
        if error != nil {
            print(error)
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            if error != nil {
                return
            }
        }
        
        print("Successfully logged into Facebook.")
        
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyBoard.instantiateViewController(withIdentifier: "tabBarNav") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
            tabBarController.selectedIndex = 2
        }
    }
    
    @IBAction func skipBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "tabBarNav") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
        tabBarController.selectedIndex = 2
        }
    }
}
