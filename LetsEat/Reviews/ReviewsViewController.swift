//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 26/02/2024.
//

import UIKit

class ReviewsViewController: UIViewController {

<<<<<<< HEAD
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedRestaurantID: Int?
    private var reviewItems: [ReviewItem] = []
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkReviews()
    }
    
}

private extension ReviewsViewController{
    func initialize(){
        setupCollectionView()
    }
    
    func setupCollectionView(){
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flow
        
    }
    
    //This method retrieves all restaurant reviews for the specified restaurant identifier
    func checkReviews(){
        //assigns restaurantDetailViewController to a constant temporarily
        let viewController = self.parent as? RestaurantDetailViewController
        //assigns the restaurant identifier of the restaurant shown in the detail screen to restaurantID
        if let restaurantID = viewController?.selectedRestaurant?.restaurantID{
            //gets an array of reviews matching the given restaurantID and assigns it to reviewItems
            reviewItems = CoreDataManager.shared.fetchReviews(by: restaurantID)
                /*If there are reviews for this restaurant, the collection view’s background view is set to nil; otherwise, you create a NoDataView instance, set the title and desc properties to "Reviews"
            and "There are currently no reviews" respectively, and assign it to the collection view’s background view.”
                 */
            if !reviewItems.isEmpty{
                collectionView.backgroundView = nil
            }else{
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews", desc: "There are currently no reviews")
            }
        }
        collectionView.reloadData()
    }
}

extension ReviewsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let reviewItem = reviewItems[indexPath.item]
        cell.nameLabel.text = reviewItem.name
        cell.titleLabel.text = reviewItem.title
        cell.reviewLabel.text = reviewItem.customerReview
        
        if let reviewItemDate = reviewItem.date{
            cell.dateLabel.text = dateFormatter.string(from: reviewItemDate)
        }
        
        if let reviewItemRating = reviewItem.rating{
            cell.ratingsView.rating = reviewItemRating
        }
        return cell
    }
}

extension ReviewsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInset = 7.0
        if reviewItems.count == 1{
            let cellWidth = collectionView.frame.size.width - (edgeInset * 2)
            return CGSize(width: cellWidth, height: 200)
        }else{
            let cellWidth = collectionView.frame.size.width - (edgeInset * 3)
            return CGSize(width: cellWidth, height: 200)
        }
    }
=======
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

>>>>>>> dev
}
