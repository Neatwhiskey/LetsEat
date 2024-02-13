//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 02/02/2024.
//

import Foundation

struct ExploreItem{
    let name: String?
    let image: String?
}

extension ExploreItem{
    init(dict:[String:String]){
        self.name = dict["name"]
        self.image = dict["image"]
    }
}
