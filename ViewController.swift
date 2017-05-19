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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Connect the Map.
    @IBOutlet var mapView: MKMapView!
    
    var mapBusinessArray = [Business]()
    //var startedLoadingPOIs = false
    let locationManger = CLLocationManager()
    var ref:FIRDatabaseReference?
    var handle : FIRDatabaseHandle?
    var selectedAnnotation: MKPointAnnotation!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        annotationSetUp()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func annotationSetUp() {
        
        // Look at this... This is the same as in my list view...
        ref = FIRDatabase.database().reference()
        handle =  ref?.child("Businesses").child("Type").child("Restaurants").observe(.childAdded, with: { (snapshot) in
            
            // Add things here
            let businessAndValues = Business(values: (snapshot.value as? [String:AnyObject])!, name:snapshot.key)
            
            self.mapBusinessArray.append(businessAndValues)
            
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
                    // Under 5 miles
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
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass over the object.
        if segue.identifier == "fromMapToDetailsVC" {
            if let destination = segue.destination as? DetailsVC {
                destination.namePassed = selectedAnnotation.title!
            }
        }
    }
}

