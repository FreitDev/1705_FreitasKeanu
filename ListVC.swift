
//  ListVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/9/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.


import UIKit

internal let cellReuse = "Cell1_Reuse"

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let businesses = ["Viet Nomz", "Marcos Pizza", "Crispers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Bring the data and reload tableView.
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableViewCell Callbacks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1_Reuse", for: indexPath)
            as? ListTableViewCell
            else{ return tableView.dequeueReusableCell(withIdentifier: "Cell1_Reuse", for: indexPath)
        }
                let scores = businesses[indexPath.row]
                cell.nameLbl?.text = scores

                return cell
    }

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
