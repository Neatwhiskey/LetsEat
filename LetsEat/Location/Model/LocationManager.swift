//
//  LocationManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 02/02/2024.
//

import Foundation
class LocationManager{
    private var locations:[LocationItem] = []
    
    //This method calls the loadData method which returns an array of explore items dictionary
    func fetch(){
        for location in loadData(){
            locations.append(LocationItem(dict: location))
        }
    }
    //This will read the content of the ExploreData.plist file and return an array of dictionaries
    private func loadData()->[[String:String]]{
        let decoder = PropertyListDecoder()
        
        if let path = Bundle.main.path(forResource: "Locations", ofType: "plist"),
           let locationData = FileManager.default.contents(atPath: path),
           let locations = try? decoder.decode([[String:String]].self, from: locationData){
            return locations
        }
        return [[:]]
    }
    
    func numberOfLocationItems()->Int{
        locations.count
    }
    
    func locationItem(at index: Int)-> LocationItem{
        locations[index]
    }
}
