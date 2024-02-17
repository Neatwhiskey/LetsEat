//
//  FilterDataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 13/02/2024.
//

import Foundation

class FilterDataManager: DataManager{
    func fetch() -> [FilterItem]{
        var filterItems: [FilterItem] = []
        
        for data in loadPlist(file: "FilterData"){
            filterItems.append(FilterItem(dict: data as![String: String]))
        }
        return filterItems
    }
}
