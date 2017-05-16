//
//  Business.swift
//  v0rtx
//
//  Created by Keanu Freitas on 5/10/17.
//  Copyright © 2017 Keanu Freitas. All rights reserved.
//

import Foundation
import UIKit

class Business {
    
    let name : String?
    let address : String
    let longitude : Double
    let latitude : Double
    
    // Will add this data in later. 
    
//    let distance : Int
//    let genre : String
//    let topic : String
//    let phoneNumber : String
//    let website : URL
//    let menu : URL
//    let rating : String
//    let hours : [String : String]
//    let images : [UIImage]
//    let deals : [String : String]
    
    init(values:[String:AnyObject], name:String) {
        self.address = values["address"] as! String
        self.longitude = values["longitude"] as! Double
        self.latitude = values["latitude"] as! Double
        self.name = name
    }
    
    // Might still need this so I am leaving this for now.
    
//    init(name : String, address : String, longitude : Double, latitude : Double ) {
//        self.name = name
//        self.address = address
//        self.longitude = longitude
//        self.latitude = latitude
//        
//    }
}
