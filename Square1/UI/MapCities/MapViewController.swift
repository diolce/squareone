//
//  MapViewController.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 1/11/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //MARK:- @IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK:- Properties
    lazy var viewModel:MapCitiesModelView  = {
        return MapCitiesModelView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        initVM()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let citySelected = viewModel.citySelected {
            navigationController?.setNavigationBarHidden(false, animated: animated)
            self.setPinUsingMKAnnotation(name:nil,location: citySelected)
        }
    }
    
    func initVM() {
        self.viewModel.putAnnotationsClosure = {
            DispatchQueue.main.async {
                for annotation in self.viewModel.annotationsCities {
                    self.setPinUsingMKAnnotation(annotationCity: annotation)
                }
                let region = MKCoordinateRegion(.world)
                self.mapView.setRegion(region, animated: true)
            }
        }
        
        if viewModel.citySelected == nil {
            self.viewModel.getAnnotationCities()
        }
    }
    
    func setPinUsingMKAnnotation(name:String?,location: CLLocationCoordinate2D) {
        let pin1 = MapPin(title: "Selected city", locationName: "", coordinate: location)
        let coordinateRegion = MKCoordinateRegion(center: pin1.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotations([pin1])
    }
    
    func setPinUsingMKAnnotation(annotationCity:AnnotationCity) {
        let pin1 = MapPin(title: annotationCity.city, locationName: "", coordinate: annotationCity.coordinate)
        mapView.addAnnotations([pin1])
    }
}

//MARK: — MKMapView Delegate Methods
extension MapViewController: MKMapViewDelegate {
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let Identifier = "Pin"
      let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
   
      annotationView.canShowCallout = true
      if annotation is MKUserLocation {
         return nil
      } else if annotation is MapPin {
         annotationView.image = UIImage(named: "PinCity")
         return annotationView
      } else {
         return nil
      }
   }
}
