//
//  ReviewFormController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 13/02/2024.
//

import UIKit

class ReviewFormController: UITableViewController {

    var selectedRestaurantID: Int?
    @IBOutlet var ratingsView: RatingsView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var nameTextTfield: UITextField!
    @IBOutlet var reviewTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurantID as Any)

    }
}

private extension ReviewFormController{
    @IBAction func saveOnTapped(_sender: Any){
        
        var reviewItem = ReviewItem()
        reviewItem.rating = ratingsView.rating
        reviewItem.title = titleTextField.text
        reviewItem.name = nameTextTfield.text
        reviewItem.customerReview = reviewTextView.text
        
        if let selRestID = selectedRestaurantID{
            reviewItem.restaurantID = Int64(selRestID)
        }
        CoreDataManager.shared.addReview(reviewItem)
        dump(ratingsView.rating)
        dump(titleTextField.text as Any)
        dump(nameTextTfield.text as Any)
        dump(reviewTextView.text as Any)
        dismiss(animated: true)
    }

}
