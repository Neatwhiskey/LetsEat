//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 02/02/2024.
//

import Foundation

class ExploreDataManager: DataManager{
    
    private var exploreItems:[ExploreItem] = []
    
    //this method calls fetch method which returns an array of explore items dictionary
    func fetch(){
        for data in loadPlist(file: "ExploreData"){
            exploreItems.append(ExploreItem(dict: data as! [String: String]))
        }
    }
    
    //This will read the content of the ExploreData.plist file and return an array of dictionaries
//    private func loadData() -> [[String: String]] {
//        //PropertyListDecoder
//        let decoder = PropertyListDecoder()
//        //This statement attempts to get the path to the ExploreData.plist and file and assigns it to a constant
//        if let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
//           //This statement attempt to get the ExploreData.plist file stored at path and assigns it to a constant
//            let exploreData = FileManager.default.contents(atPath: path),
//           //This statement attempts to create an array from the content of ExploreData.plist and assigns it to a constant
//            let exploreItems = try? decoder.decode([[String: String]].self, from: exploreData) {
//            //if the optional binding is successful, this statement returns exploreItems as an array of dictionaries of the [String:String] type
//            return exploreItems
//        }
//        //if the optional binding is unsuccessful, this statement returns an array of an empty dictionary
//        return [[:]]
//    }
    
    //This will determine the number of cells to be displayed in the collectionView
    func numberOfExploreItems() -> Int{
        exploreItems.count
    }
    
    //This will return an explore item instance corresponding to a cell's position in the collectionView
    func exploreItem(at index: Int) -> ExploreItem{
        exploreItems[index]
    }
}

