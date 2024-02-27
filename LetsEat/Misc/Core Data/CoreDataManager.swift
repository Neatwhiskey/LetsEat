//
//  CoreDataManager.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 23/02/2024.
//

import Foundation
import CoreData

struct CoreDataManager{
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "LetsEatModel")
        container.loadPersistentStores{
            (storeDesc, error) in
            error.map{
                dump($0)
            }
        }
    }
    
    func fetchRestaurantRating(by identifier: Int) ->Double{
        let reviewItems = fetchReviews(by: identifier)
        let sum = reviewItems.reduce(0,{$0 + ($1.rating ?? 0)})
        
        return sum / Double(reviewItems.count)
    }
    
    func addReview(_ reviewItem: ReviewItem){
        let review = Review(context: container.viewContext)
        review.date = Date()
        if let reviewItemRating = reviewItem.rating{
            review.rating = reviewItemRating
        }
        review.title = reviewItem.title
        review.name = reviewItem.name
        review.customerReview = reviewItem.customerReview
        if let reviewItemRestaurantID = reviewItem.restaurantID{
            review.restaurantID = reviewItemRestaurantID
        }
        review.uuid = reviewItem.uuid
        
        save()
    }
    
    func addPhoto(_ restPhotoItem: RestaurantPhotoItem){
        let restPhoto = RestaurantPhoto(context: container.viewContext)
        restPhoto.date = Date()
        restPhoto.photo = restPhotoItem.photoData
        if let restPhotoID = restPhotoItem.restaurantID{
            restPhoto.restaurantID = restPhotoID
        }
        restPhoto.uuid = restPhotoItem.uuid
        
        save()
    }
    
    func fetchReviews(by identifier: Int) -> [ReviewItem]{
        //Create a NSManagedObjectContext instance
        let moc = container.viewContext
        //Creates a fetch request that retrieves Review instances from the persistent store
        let request = Review.fetchRequest()
        //Creates a fetch predicate that only fetches those Review instances with the specified restaurantID
        let predicate = NSPredicate(format: "restaurantID = %i", identifier)
        //Creates an array of ReviewItems to store the results of the fetch request in
        var reviewItems: [ReviewItem] = []
        //Sorts the results of the fetch request by date, with the most recent items first
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        //Sets the predicate for the fetch request
        request.predicate = predicate
        
        /*
         The do catch blockperforms the fetch request and place the results in the items array
         if unsuccessful, the app crashes and an error message will be printed in the Debug area
         */
        do{
            for review in try moc.fetch(request){
                reviewItems.append(ReviewItem(review: review))
            }
            return reviewItems
        }catch{
            fatalError("failed to fetch reviews: \(error)")
        }
    }
    
    func fetchRestPhotos(by identifier: Int) -> [RestaurantPhotoItem]{
        //Create a NSManagedObjectContext instance
        let moc = container.viewContext
        //Creates a fetch request that retrieves RestaurantPhoto instances from the persistent store
        let request = RestaurantPhoto.fetchRequest()
        //Creates a fetch predicate that only fetches those Review instances with the specified restaurantID
        let predicate = NSPredicate(format: "restaurantID = %i", identifier)
        //Creates an array of RestaurantPhotoItems to store the results of the fetch request in
        var restPhotoItems: [RestaurantPhotoItem] = []
        //Sorts the results of the fetch request by date, with the most recent items first
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        //Sets the predicate for the fetch request
        request.predicate = predicate
        
        /*
        The do catch blockperforms the fetch request and place the results in the items array
        if unsuccessful, the app crashes and an error message will be printed in the Debug area
         */
        do{
            for restPhoto in try moc.fetch(request){
                restPhotoItems.append(RestaurantPhotoItem(restaurantPhoto: restPhoto))
            }
            return restPhotoItems
        }catch{
            fatalError("failed to fetch restaurant photos: \(error)")
        }
    }
    
    private func save(){
        do{
            if container.viewContext.hasChanges{
                try container.viewContext.save()
            }
        }catch let error{
            dump(error.localizedDescription)
        }
    }
}
