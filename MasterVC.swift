//
//  MasterVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/9/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import UIKit

class MasterVC: UIViewController {
    
    @IBOutlet var mapAndListControl: UISegmentedControl!
    
    lazy var mapVC : ViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var listVC : ListVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ListVC") as! ListVC
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        setupSegmentedControl()
        updateView()
    }
    
    func updateView(){
        mapVC.view.isHidden = !(mapAndListControl.selectedSegmentIndex == 0)
        listVC.view.isHidden = (mapAndListControl.selectedSegmentIndex == 0)
    }
    
    func setupSegmentedControl(){
        mapAndListControl.removeAllSegments()
        mapAndListControl.insertSegment(withTitle: "Map", at: 0, animated: false)
        mapAndListControl.insertSegment(withTitle: "List", at: 1, animated: false)
        
        mapAndListControl.addTarget(self, action: #selector(selectionDidCHanged(sender:)), for: .valueChanged)
        mapAndListControl.selectedSegmentIndex = 0
        
    }
    
    func selectionDidCHanged(sender:UISegmentedControl) {
        updateView()
    }
    
    func addViewControllerAsChildViewController(childViewController: UIViewController){
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    func removeViewControllerAsChildViewController(childViewController: UIViewController){
        childViewController.willMove(toParentViewController: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParentViewController()
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
