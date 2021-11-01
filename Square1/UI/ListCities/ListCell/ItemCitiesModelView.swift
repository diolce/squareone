//
//  ItemCitiesModelView.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 1/11/21.
//

import Foundation

class ItemCitiesModelView: ListCitiesModelViewBase {
    var page: Int = -1
    var name: String = ""
    var lat: String = ""
    var log: String = ""
    var created: String = ""
    var updated: String = ""
    var hasCountry = false
    var nameCountry = ""
    var codeCountry = ""
    var createdCountry = ""
    var updatedCountry = ""
    
    //Update from cell
    var item:Item? = nil {
        didSet {
            if let item = item {
                name = item.name ?? ""
                lat = String(item.lat ?? 0.0)
                log = String(item.lng ?? 0.0)
                created = item.created_at ?? ""
                updated = item.updated_at ?? ""
                hasCountry = item.country != nil
                if let country = item.country {
                    nameCountry = country.name ?? ""
                    codeCountry = country.code ?? ""
                    createdCountry = country.created_at ?? ""
                    updatedCountry = country.updated_at ?? ""
                    reloadViewClosure?()
                }
            }
        }
    }
    
    func countryForItem(city:String) {
        self.fetchCitiesAPI(page: nil, filter: city,include_country: true) {
            result in
            switch result {
            case .success( _):
                if let item = self.getCountryForItem(city:city) { self.item = item }
            case .failure( _): break
            }
        }
    }
    
    var reloadViewClosure: (()->())?
}
