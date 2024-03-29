//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 08/02/2024.
//

import Foundation

class RestaurantDataManager{
    private var restaurantItems: [RestaurantItem] = []
    
    func fetch(location: String, selectedCuisine: String = "All", completionHandler: (_ restaurantItems: [RestaurantItem])-> Void){
        if let file = Bundle.main.url(forResource: location, withExtension: "json"){
            do{
                let data = try Data(contentsOf: file)
                let restaurants  = try JSONDecoder().decode([RestaurantItem].self, from: data)
                if selectedCuisine != "All"{
                    restaurantItems = restaurants.filter{
                        ($0.cuisines.contains(selectedCuisine))
                    }
                }else{
                    restaurantItems = restaurants
                }
            }catch{
                print("There was an error \(error)")
            }
        }
        completionHandler(restaurantItems)
    }
    
    func numberOfRestaurantItems()->Int{
        restaurantItems.count
    }
    
    func restaurantItems(at index: Int) -> RestaurantItem{
        restaurantItems[index]
    }
}
