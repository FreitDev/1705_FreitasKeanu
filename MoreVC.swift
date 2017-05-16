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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
}
