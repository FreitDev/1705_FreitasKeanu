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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // Connect the Map.
    @IBOutlet var mapView: MKMapView!
    
    let locationManger = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        print(locationManger.location?.coordinate as Any)
        
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

    // Test to see if the Repo is working...

}

