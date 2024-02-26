//
//  FilterItem.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 13/02/2024.
//

import Foundation
struct FilterItem{
    let filter: String?
    let name : String?
    
    init(dict: [String: String]){
        self.filter = dict["filter"]
        self.name = dict["name"]
    }
}
