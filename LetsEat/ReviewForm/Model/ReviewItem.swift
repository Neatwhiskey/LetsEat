//
//  ReviewItem.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 23/02/2024.
//

import Foundation
import UIKit

struct ReviewItem{
    var date: Date?
    var restaurantID: Int64?
    var rating: Double?
    var title: String?
    var name: String?
    var customerReview: String?
    var uuid = UUID()
}

extension ReviewItem{
    init(review: Review){
        self.date = review.date
        self.restaurantID = review.restaurantID
        self.rating = review.rating
        self.title = review.title
        self.name = review.name
        self.customerReview = review.customerReview
        
        if let reviewUUID = review.uuid{
            self.uuid = reviewUUID
        }
    }
}
