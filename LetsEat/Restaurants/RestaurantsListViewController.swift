//
//  RestaurantsListViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 30/08/2022.
//

import UIKit

class RestaurantsListViewController: UIViewController, UICollectionViewDelegate{
    
  
    @IBOutlet var restaurantCollectionView: UICollectionView!
    
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

}

//MARK: - Private extension
extension RestaurantsListViewController{
    
}

//MARK: - UICollectionViewDataSource
extension RestaurantsListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
        return cell
    }
    
}
