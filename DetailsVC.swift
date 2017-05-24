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
    @IBOutlet var favoritesBtn: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    
    var namePassed = String()
    var addressPassed = String()
    var imagePassed = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLbl.text = namePassed
        addressLbl.text = addressPassed
    }
    
    @IBAction func favoritesBtnTapped(_ sender: UIButton) {
        print("This is working!")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
