//
//  listCitiesRequest.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation

class ListCitiesRequest: APIRequest {
    var parameters: [String : Any]?
    var baseURLString: String

    var relativePath: String = "/city"
    var method: HTTPMethod = .get

    var queryItem: [URLQueryItem]? = []

    init(baseUrl: String, page: Int?, filter:String?,include_country:Bool = false) {
        
        self.baseURLString = baseUrl
        
        if include_country {
            let queryItem = URLQueryItem(name: "include", value: "country")
            self.queryItem?.append(queryItem)
        }
        
        if let page = page {
            let queryItem = URLQueryItem(name: "page", value: String(page))
            self.queryItem?.append(queryItem)
        }
        
        if let filter = filter {
            let queryItem = URLQueryItem(name: "filter[0][name][contains]", value: filter)
            self.queryItem?.append(queryItem)
        }
        
    }
}
