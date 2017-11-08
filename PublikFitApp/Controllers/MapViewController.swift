//
//  SecondViewController.swift
//  PublikFitApp
//
//  Created by Breno Ramos on 06/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct PlaceStruct:Decodable {
    let area : String
    let codigo_bairro : Int
    let codigo_logradouro : Int
    let endereco_equip_urbano : String
    let latitude : Float
    let lei_equip_urbano : String
    let longitude : Float
    let nome_bairro : String
    let nome_equip_urbano : String
    let nome_oficial_equip_urbano : String
    let perimetro : String
    let tipo_equip_urbano : String
}


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManagerSetup()
        
        //download places and display them
        let url = URL(fileReferenceLiteralResourceName: "pracas-parquesRecife.json")
        do {
            let data = try Data(contentsOf: url)
            print(data)
            do{
                let places = try JSONDecoder().decode([PlaceStruct].self, from: data)
                print(places)
                
                for i in places{
                    let annotation = Place(title: i.nome_oficial_equip_urbano, subtitle: i.nome_bairro, coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(i.latitude), longitude: CLLocationDegrees(i.longitude)))
                    self.mapView.addAnnotation(annotation)
                }
                
                
            } catch let jsonErr {
                print("failed:", jsonErr)
            }
 
        } catch let dataErr {
            print("failed Data:", dataErr)
        }

    }
    
    fileprivate func locationManagerSetup() {
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationCoordinateValue : CLLocationCoordinate2D = try locationManager.location!.coordinate
        let locationValue = CLLocation(latitude: locationCoordinateValue.latitude, longitude: locationCoordinateValue.longitude)
        print("locations = \(locationCoordinateValue.latitude) \(locationCoordinateValue.longitude)")
        centerMapOnLocation(location: locationValue)
    }
    
    func centerMapOnLocation(location:CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        print("set region")
        mapView.setRegion(coordinateRegion, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reusableIdentifier = "annotationId"
        let annotation = Place(title: "Praça da várzea", subtitle: "5 estrelas", coordinate: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417))
        
        let newAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reusableIdentifier)
        //newAnnotationView.image = ?
        newAnnotationView.canShowCallout = true
        newAnnotationView.isEnabled = true
        
        return newAnnotationView
    }

}

