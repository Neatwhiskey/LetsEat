//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 08/02/2024.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    var selectedRestaurant: RestaurantItem?
    
    //navbar
    @IBOutlet var heartButton: UIBarButtonItem!
    //cell one
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cuisineLabel:UILabel!
    @IBOutlet var headerAddressLabel: UILabel!
    // cell two
    @IBOutlet var tableDetailsLabel: UILabel!
    //cell three
    @IBOutlet var overallRatingLabel: UILabel!
    @IBOutlet var ratingsView: RatingsView!
    //cell eight
    @IBOutlet var addressLabel: UILabel!
    // cell nine
    @IBOutlet var locationMapImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedRestaurant as Any)
        initalize()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
     //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue){
        
    }
    

}

private extension RestaurantDetailViewController{
    
    func initalize(){
        setUpLabels()
        createMap()
        createRating()
    }
    
    func createRating(){
        ratingsView.rating = 3.5
        ratingsView.isEnabled = true
    }
    func setUpLabels(){
        guard let restaurant = selectedRestaurant else{
            return
        }
        title = restaurant.name
        nameLabel.text = title
        
        cuisineLabel.text = restaurant.subtitle
        
        headerAddressLabel.text = restaurant.address
        
        tableDetailsLabel.text = "Table for 7, tonight at 10:00 PM"
        
        addressLabel.text = restaurant.address
    }
    
    func createMap(){
        guard let annotation = selectedRestaurant,
              let long = annotation.long,
              let lat = annotation.lat else{
            return
        }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSnapshot(with: location)
    }
    
    func takeSnapshot(with location: CLLocationCoordinate2D){
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.pointOfInterestFilter = .includingAll
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start(){snapshot, error in
            guard let snapshot = snapshot else{
                return
            }
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.locationMapImageView.bounds
            if rect.contains(point){
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width/2
                point.y -= pinView.bounds.size.height/2
                
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                DispatchQueue.main.async{
                    self.locationMapImageView.image = image
                }
            }
        }
    }
}
