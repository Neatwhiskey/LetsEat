//
//  LocationItem.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 08/02/2024.
//

import Foundation

struct LocationItem: Equatable{
    let city: String?
    let state: String?
}

extension LocationItem{
    init(dict:[String: String]){
        self.city = dict["city"]
        self.state = dict["state"]
    }
    var cityAndState: String{
        guard let city = self.city,
              let state = self.state else{
            return ""
        }
        return "\(city),\(state)"
    }
}
