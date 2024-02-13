//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 06/02/2024.
//

import Foundation
import MapKit

class MapDataManager: DataManager{
    private var items:[RestaurantItem] = []
    var annotations: [RestaurantItem]{
        items
    }
    func fetch(completion:(_ annotations: [RestaurantItem]) -> ()){
        let manager = RestaurantDataManager()
        manager.fetch(location: "Boston", completionHandler: {
            (restaurantItems) in
            self.items = restaurantItems
            completion(items)
        })
    }
    
    // this method returns an MKCoordinateRegion instance 
    func initialRegion(latData: CLLocationDegrees, longData: CLLocationDegrees) -> MKCoordinateRegion{
        guard let item = items.first else{
            return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: latData, longitudeDelta: longData)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
//    private func loadData() -> [[String: AnyObject]]{
//        guard let path = Bundle.main.path(forResource: "MapLocations", ofType: "plist"),
//              let itemsData = FileManager.default.contents(atPath: path),
//              let items = try! PropertyListSerialization.propertyList(from: itemsData, format: nil) as? [[String:AnyObject]] else{
//            return [[:]]
//        }
//        return items
//    }
}
