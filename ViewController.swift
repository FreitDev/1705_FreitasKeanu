//
//  ViewController.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/1/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import Firebase
import FirebaseStorage

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Connect the Map.
    @IBOutlet var mapView: MKMapView!
    
    var coordinates = [Int]()
    let locationManger = CLLocationManager()
    var ref:FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Map Functionality
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let updatedLocation = locations[0]
        
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let userLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(updatedLocation.coordinate.latitude, updatedLocation.coordinate.longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
    }
    
}

