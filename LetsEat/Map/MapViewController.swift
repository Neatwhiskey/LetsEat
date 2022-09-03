//
//  MapViewController.swift
//  LetsEat
//
//  Created by Jamaaldeen Opasina on 01/09/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController{

    @IBOutlet var mapView: MKMapView!
    private let manager =  MapDataManager()
    var selectedRestaurant: RestaurantItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier!{
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue:segue)
        default:
            print("segue not yet added")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

//MARK: - private extension
extension MapViewController{
    
    func initialize(){
        mapView.delegate = self
        manager.fetch{(annotations)in
            setupMap(annotations)
        }
    }
    func setupMap(_ annotations: [RestaurantItem]){
        mapView.setRegion(manager.initialRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
    func showRestaurantDetail(segue:UIStoryboardSegue){
        if let viewController = segue.destination as? RestaurantDetailViewController,
           let restaurant = selectedRestaurant{
            viewController.selectedRestaurant = restaurant
        }
    }
}

//MARK: - MapViewDelegate
extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else{return}
        selectedRestaurant = annotation as? RestaurantItem
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customPin"
        guard !annotation.isKind(of: MKUserLocation.self)
        else{
            return nil
        }
        let annotationView: MKAnnotationView
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
            annotationView = customAnnotationView
            annotationView.annotation = annotation
        }else{
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        annotationView.canShowCallout = true
        if let image = UIImage(named: "custom-annotation"){
            annotationView.image = image
            annotationView.centerOffset = CGPoint(x: -image.size.width/2, y: -image.size.height/2)
        }
        return annotationView
    }
    
}
