//
//  DetailsVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/10/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    
    var namePassed = String()
    var addressPassed = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLbl.text = namePassed
        addressLbl.text = addressPassed
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
