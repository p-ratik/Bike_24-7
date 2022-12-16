//
//  ContactViewController.swift
//  Bike_24*7
//
//  Created by Capgemini-DA204 on 12/14/22.
//

import UIKit
import MapKit



class ContactViewController: UIViewController {
    
    
    
    @IBOutlet weak var maps: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Map
        let latitude: CLLocationDegrees = 12.951845
        let longitude : CLLocationDegrees = 77.699577
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta:latDelta, longitudeDelta: lonDelta)
        let region : MKCoordinateRegion = MKCoordinateRegion(center:location, span: span)
        self.maps.setRegion(region,animated: true)
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Marathahalli"
        annotation.subtitle = "ABCD Showroom"
        self.maps.addAnnotation(annotation)
        
        
        
    }
    @IBAction func contactUsBackButtonClicked(_ sender: Any) {
        let customTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarController")  as! UITabBarController
        self.navigationController?.pushViewController(customTabBarController, animated: true)

    }
}
