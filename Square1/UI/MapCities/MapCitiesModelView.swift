//
//  MapCitiesModelView.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 1/11/21.
//

import Foundation
import MapKit

class MapCitiesModelView:ListCitiesModelViewBase {
    override init() { super.init() }
    
    ///Constructor
    init(lat:CGFloat,lng:CGFloat) {
        super.init()
        self.citySelected = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
    }
    
    var citySelected: CLLocationCoordinate2D? = nil
    
    var annotationsCities:[AnnotationCity] = [AnnotationCity]() {
        didSet {
            putAnnotationsClosure?()
        }
    }
    
    var items: [Item]? = nil {
        didSet {
            if let items = items {
                self.toAnnotationCity(items:items)
            }
        }
    }
    
    func getAnnotationCities() {
        self.items = self.getAllCities()
    }
    
    func toAnnotationCity(items:[Item]) {
        var aux = [AnnotationCity]()
        for item in items {
            if let lat = item.lat, let lng = item.lng {
            aux.append(AnnotationCity(city: item.name ?? "", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))))
            }
        }
        self.annotationsCities = aux
    }
    
    var putAnnotationsClosure: (()->())?
}
