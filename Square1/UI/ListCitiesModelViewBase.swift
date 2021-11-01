//
//  ListCitiesModelViewBase.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 31/10/21.
//

import Foundation
import RealmSwift

class ListCitiesModelViewBase {
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    func saveData(_ items:[Item]) {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL?.absoluteString ?? "")
            for item in items {
                try realm.write {
                    realm.add(item,update: .all)
                }
            }
        }
        catch let exception { print(exception) }
    }
    
    ///Get all cities
    func getAllCities() -> [Item]? {
        do {
            let realm = try Realm()
            let item = realm.objects(Item.self)
            return Array(item)
        }
        catch let exception { print(exception) }
        return nil
    }
 
    ///Get items contains city string
    func getItemsContains(city:String) -> [Item]? {
        do {
            let realm = try Realm()
            let item = realm.objects(Item.self).filter("name CONTAINS '\(city)'")
            return Array(item)
        }
        catch {
            print("Error in read data")
        }
        return nil
    }
    
    ///Get country for city
    func getCountryForItem(city:String) -> Item? {
        do {
            let realm = try Realm()
            let item = realm.objects(Item.self).filter("name = '\(city)'")
            return Array(item).first
        }
        catch {
            print("Error in read data")
        }
        return nil
    }
    
    func fetchCitiesAPI(page: Int?,
                        filter: String?,
                        include_country: Bool = false,
                        completion: @escaping (Result<JsonData,ErrorModel>)-> Void) {
        //self.isLoading = true
        ApiManager.shared.listCities(page: page, filter: filter, include_country: include_country) { result in
            switch result {
                case .success(let data):
                    if let data = data.data { self.saveData(Array(data.items))}
                    completion(.success(data))
                case .failure(let errorModel):
                    completion(.failure(errorModel))
            }
        }
    }
    
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
}
