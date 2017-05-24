//
//  MasterVC.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/9/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class MasterVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mapAndListControl: UISegmentedControl!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    var mapBusinessArray = [Business]()
    let locationManger = CLLocationManager()
    
    //var startedLoadingPOIs = false
    var ref:FIRDatabaseReference?
    var handle : FIRDatabaseHandle?
    var selectedAnnotation: MKPointAnnotation!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        segmentedControl()
        annotationSetUp()
        update()
        viewControllerDidLoad()
        
        tableView.alpha = 0
    }
    
    func viewControllerDidLoad(){
        mapView.delegate = self
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        print(locationManger.location?.coordinate as Any)
        
        
        // This is testing to use Firebase Storage for my imgaes.  I will use this later...
        let reference = FIRStorage.storage().reference()
        
        let image = UIImageJPEGRepresentation(#imageLiteral(resourceName: "Logo"), 0.5)
        reference.child("Images").put(image!, metadata: nil) { (metadata, error) in
            if let imageURl = metadata?.downloadURL()?.absoluteString {
                print(imageURl)
            }
        }

    }
    
    // MARK: - Map Functionality
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let updatedLocation = locations[0]
        
        let userLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(updatedLocation.coordinate.latitude, updatedLocation.coordinate.longitude)
        
        let span = MKCoordinateSpanMake(0.075, 0.075)
        
        
        let region = MKCoordinateRegion(center: userLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view!.canShowCallout = true
            view!.animatesDrop = true
        }
        
        view?.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIButton
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            selectedAnnotation = view.annotation as? MKPointAnnotation
            performSegue(withIdentifier: "fromMapToDetailsVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass over the object.
        if segue.identifier == "fromMapToDetailsVC" {
            if let destination = segue.destination as? DetailsVC {
                destination.namePassed = selectedAnnotation.title!
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func annotationSetUp() {
        
        // Look at this... This is the same as in my list view...
         let ref = FIRDatabase.database().reference()
         let handle =  ref.child("Businesses").child("Type").child("Restaurants").observe(.childAdded, with: { (snapshot) in
            
            // Add things here
            let businessAndValues = Business(values: (snapshot.value as? [String:AnyObject])!, name:snapshot.key)
            
            self.mapBusinessArray.append(businessAndValues)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            for item in self.mapBusinessArray {
                
                let annotation = MKPointAnnotation()
                annotation.title = item.name
                annotation.subtitle = item.address
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                
                let itemLocation = CLLocation(latitude: item.latitude, longitude: item.longitude)
                
                let distance = (self.locationManger.location?.distance(from: itemLocation))!
                let distanceInMiles = distance / 1609.344
                
                print(String(format: "The distance to the retaurant is %.01f miles", distanceInMiles))
                
                if(distanceInMiles <= 5)
                {
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(annotation)
                    }
                }
                else
                {
                    // Out of 5 mile range
                    print("annotation not in range")
                }
            }
            
            

            //self.mapVC.mapBusinessArray = self.mapBusinessArray
            //self.listVC.businessArray = self.mapBusinessArray
            
            /*
            */
        })
    }

    // MARK: - TableViewCell Callbacks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapBusinessArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1_Reuse", for: indexPath)
            as? ListTableViewCell
            else{ return tableView.dequeueReusableCell(withIdentifier: "Cell1_Reuse", for: indexPath)
        }
        
        let scores = mapBusinessArray[indexPath.row]
        cell.nameLbl?.text = scores.name
        cell.addressLbl?.text = scores.address
        
        return cell
    }

    
    func update(){
        //mapVC.view.isHidden = !(mapAndListControl.selectedSegmentIndex == 0)
        //listVC.view.isHidden = (mapAndListControl.selectedSegmentIndex == 0)
    }
    
    func segmentedControl(){
        
        mapAndListControl.removeAllSegments()
        mapAndListControl.insertSegment(withTitle: "Map", at: 0, animated: false)
        mapAndListControl.insertSegment(withTitle: "List", at: 1, animated: false)
        
        mapAndListControl.addTarget(self, action: #selector(selectionDidCHanged(sender:)), for: .valueChanged)
        mapAndListControl.selectedSegmentIndex = 0
        
    }
    
    func selectionDidCHanged(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.alpha = 1
            tableView.alpha = 0
        } else {
            mapView.alpha = 0
            tableView.alpha = 1
        }
    }

}
