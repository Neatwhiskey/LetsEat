//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 01/09/2022.
//

import UIKit
import MapKit

class RestaurantItem: NSObject, MKAnnotation {
    let name: String?
    let cuisines: [String]
    let lat: Double?
    let long: Double?
    let address: String?
    let postalCode: String?
    let state: String?
    let imageUrl: String?
    let restaurantID: Int?
    
    init(dict:[String:AnyObject]){
        self.lat = dict["lat"] as? Double
        self.state = dict["state"] as? String
        self.address = dict["address"] as? String
        self.long = dict["long"] as? Double
        self.postalCode = dict["postalCode"] as? String
        self.imageUrl = dict["imageUrl"] as? String
        self.cuisines = dict["cuisines"] as? [String] ?? []
        self.restaurantID = dict["restaurantID"] as? Int
        self.name = dict["name"] as? String
    }
    
    var coordinate: CLLocationCoordinate2D{
        guard let lat = lat, let long = long else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String?{
        name
    }
    var subtitle: String?{
        if cuisines.isEmpty{
            return ""
        }else if cuisines.count == 1{
            return cuisines.first
        }else{
            return cuisines.joined(separator: ", ")
        }
    }
}
