//
//  AnnotationCity.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 1/11/21.
//

import MapKit

class AnnotationCity {
    var city:String
    var coordinate:CLLocationCoordinate2D
    init(city:String, coordinate:CLLocationCoordinate2D) {
        self.city = city
        self.coordinate = coordinate
    }
}
