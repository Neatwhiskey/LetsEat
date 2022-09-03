//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 01/09/2022.
//

import Foundation
import MapKit
class MapDataManager: DataManager{
    private var items: [RestaurantItem] = []
    var annotations: [RestaurantItem]{
        items
    }
    
//    private func loadData() ->[[String:AnyObject]]{
//        guard let path = Bundle.main.path(forResource: "MapLocations", ofType: "plist"),
//              let itemsData = FileManager.default.contents(atPath: path),
//              let items = try! PropertyListSerialization.propertyList(from: itemsData, format: nil) as?[[String:AnyObject]] else{
//            return[[:]]
//        }
//        return items
//    }
    
    func fetch(completion: (_ annotations:[RestaurantItem]) -> ()){
        if !items.isEmpty{
            items.removeAll()
        }
        
        for data in loadPlist(file: "MapLocations"){
            items.append(RestaurantItem(dict: data))
        }
        completion(items)
    }
    
    func initialRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion{
        guard let item = items.first else{
            return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}
