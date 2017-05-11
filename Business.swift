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
    
    let name : String
    let address : String
    let longitude : Int
    let latitude : Int
    let distance : Int
//    let genre : String
//    let topic : String
//    let phoneNumber : String
//    let website : URL
//    let menu : URL
//    let rating : String
//    let hours : [String : String]
//    let images : [UIImage]
//    let deals : [String : String]
    
    init(name : String, address : String, distance : Int, longitude : Int, latitude : Int ) {
        self.name = name
        self.address = address
        self.distance = distance
        self.longitude = longitude
        self.latitude = latitude
    }
}
