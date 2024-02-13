//
//  MapViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 06/02/2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    @IBOutlet var mapView: MKMapView!
    
    private let manager = MapDataManager()
    var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        switch segue.identifier!{
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        default:
            print("Segue not added")
        }
        // Pass the selected object to the new view controller.
    }
}

//MARK: Private extension
private extension MapViewController{
    
    func initialize(){
        mapView.delegate = self
        manager.fetch{(annotations) in
            setUpMap(annotations)
        }
    }
    
    func setUpMap(_ annotations: [RestaurantItem]){
        mapView.setRegion(manager.initialRegion(latData: 0.5, longData: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue){
        if let viewController = segue.destination as? RestaurantDetailViewController,
           let restaurant = selectedRestaurant{
            viewController.selectedRestaurant = restaurant
        }
    }
}

//MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else{
            return
        }
        selectedRestaurant = annotation as? RestaurantItem
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customPin"
            //the guard statement verifies that the annotation is not the user's location and returns nil if it happens to be
        guard !annotation.isKind(of: MKUserLocation.self) else{
            return nil
        }
            //annotationView is a constant of the MKAnnotationView type. it is created here so it can be configured later
        let annotationView: MKAnnotationView
            //The if statement checks to see whether there are any existing annotations that were initially visible but are no longer on the screen. If there are, the MKAnnotationView instance for that annotation can be reused and is assigned to the annotationView variable. The annotation parameter is assigned to the annotation property of annotationView.
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
            annotationView = customAnnotationView
            annotationView.annotation = annotation
        }
            //The else clause is executed if there are no existing MKAnnotationView instances that can be reused. A new MKAnnotationView instance is created with the reuse identifier specified earlier (custompin). The MKAnnotationView instance is conFigureured with a callout. When you tap a pin on the map, a callout bubble will appear showing the title (restaurant name), subtitle (cuisines), and a button.
        else{
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        annotationView.canShowCallout = true
            //This configures the MKAnnotationView instance that you just created to display extra information in a callout bubble and sets the custom image to the custom-annotation image stored in Assets.xcassets. When adding a custom image, the annotation uses the center of the image as the pinpoint, so the centerOffset property is used to set the correct location of the pinpoint, at the tip of the pin.
        if let image = UIImage(named: "custom-annotation"){
            annotationView.image = image
            annotationView.centerOffset = CGPoint(x: -image.size.width/2, y: -image.size.height/2)
        }
            //returns the annotationView
        return annotationView
    }
}
