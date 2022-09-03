//
//  DataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 01/09/2022.
//

import Foundation

protocol DataManager{
    func loadPlist(file name: String) -> [[String:AnyObject]]
}

extension DataManager{
    func loadPlist(file name: String) -> [[String:AnyObject]]{
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
              let itemData = FileManager.default.contents(atPath: path),
              let items = try! PropertyListSerialization.propertyList(from: itemData, format: nil) as? [[String:AnyObject]] else{
            return [[:]]
        }
        return items
    }
}
