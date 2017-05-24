
//  ListVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/9/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.


import UIKit
import FirebaseDatabase

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var businessArray = [Business]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    var ref : FIRDatabaseReference?
    var handle : FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Bring the data and reload tableView.
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableViewCell Callbacks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1_Reuse", for: indexPath)
            as? ListTableViewCell
            else{ return tableView.dequeueReusableCell(withIdentifier: "Cell1_Reuse", for: indexPath)
        }
        
        let scores = businessArray[indexPath.row]
        cell.nameLbl?.text = scores.name
        cell.addressLbl?.text = scores.address
        
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass over the object.
        if let indexPath = tableView.indexPathForSelectedRow {
            let sendInfo = businessArray[indexPath.row]
            
            // Creating the destination to pass the object to the new ViewController.
            if let destination = segue.destination as? DetailsVC {
                destination.namePassed = sendInfo.name!
                destination.addressPassed = sendInfo.address
            }
        }
    }
}
