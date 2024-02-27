//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 25/01/2024.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate{

    let manager = ExploreDataManager()
    @IBOutlet var collectionView: UICollectionView!
    var selectedCity: LocationItem?
    var headerView: ExploreHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            //call the fetch method of the class
        initialize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Segue.restaurantList.rawValue, selectedCity == nil {
            showLocationRequiredAlert()
            return false
        }
        return true

    }
    
    
    // MARK: - Navigation
     
  

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        case Segue.restaurantList.rawValue:
            showRestaurantList(segue: segue)
        default:
            print("Segue not added")
        }
    }
}

//MARK: - Private Extension
private extension ExploreViewController{
    func initialize(){
        manager.fetch()
    }
    
    func showLocationList(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, 
                let viewController = navController.topViewController as? LocationViewController else {
            return
        }
        viewController.selectedCity = selectedCity
    }
    
    func showRestaurantList(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantListViewController, 
            let city = selectedCity,
            let index = collectionView.indexPathsForSelectedItems?.first?.row {
            viewController.selectedCuisine = manager.exploreItem(at: index).name
            viewController.selectedCity = city
        }
    }
    
    func showLocationRequiredAlert() {
        let alertController = UIAlertController(title: "Location Needed", message: "Please select a location.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue){
        if let viewController = segue.source as? LocationViewController{
            selectedCity = viewController.selectedCity
            if let location = selectedCity{
                headerView.locationLabel.text = location.cityAndState
            }
        }
    }
}

//MARK: UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        headerView = header as? ExploreHeaderView
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            //Specified the cell that is being dequeued as an instance of ExploreCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
            //Get the exploreitem instance that corresponds to the current cell in the collection cell
        let exploreItem = manager.exploreItem(at: indexPath.row)
            //set the text property of the cell's explorenamelabel to the name of the exploreitem instance
        cell.exploreNameLabel.text = exploreItem.name
            //set the image property of the cell's exploreimageview to the image of the exploreitem instance
        cell.exploreImageView.image = UIImage(named: exploreItem.image!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        manager.numberOfExploreItems()
    }
}


