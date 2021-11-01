//
//  ListCitiesViewModel.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 31/10/21.
//

import Realm
import RealmSwift

class ListCitiesModelView: ListCitiesModelViewBase {
    var isSearch:Bool = false
    
    var isLoadingNext: Bool = false {
        didSet {
            self.updateLoadingNextStatus?()
        }
    }

    var items: [Item]? = nil {
        didSet {
            if let items = items {
                self.toModelViewItem(items: items)
            }
        }
    }
    
    private var cellModelViewItem: [ItemCitiesModelView] = [ItemCitiesModelView]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    private var cellModelViewItemSearch: [ItemCitiesModelView] = [ItemCitiesModelView]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    func getCities(page:Int?,filter:String?) {
        if let page = page, page > 1 { isLoadingNext = true } else { isLoading = true }
        fetchCitiesAPI(page: page, filter: filter) { result in
            switch result {
            case .success(let data):
                //Read Data from realm
                if let data = data.data,!self.isSearch {
                    if let firstItem = data.items.first, let id = firstItem.id {
                        self.items = Array(self.getCitiesForId(id:id)!)
                    }
                } else {
                    if let filter = filter {
                        self.items = self.getItemsContains(city: filter)
                    }
                }
            case .failure( _):break
            }
            if let page = page, page > 1 { self.isLoadingNext = false } else { self.isLoading = false }
        }
    }
    
    ///Get cities id >
    func getCitiesForId(id:Int) -> [Item]? {
        do {
            let realm = try Realm()
            let items = realm.objects(Item.self).filter("id > %@",id)
            return Array(items)
        }
        catch {
            print("Error in read data")
        }
        return nil
    }
    
    ///Convert items to ItemCitiesModelView
    func toModelViewItem(items: [Item]) {
        var aux:[ItemCitiesModelView] = []
        for i in items {
            let item = ItemCitiesModelView()
            item.name = i.name ?? ""
            item.lat = String(i.lat ?? 0.0)
            item.log = String(i.lng ?? 0.0)
            item.created = i.created_at ?? ""
            item.updated = i.updated_at ?? ""
            
            item.hasCountry = i.country != nil
            if item.hasCountry {
                item.codeCountry = i.country!.code ?? ""
                item.nameCountry = i.country!.name ?? ""
                item.createdCountry = i.country!.created_at ?? ""
                item.updatedCountry = i.country!.updated_at ?? ""
            }
        
            aux.append(item)
        }
        //Add all items
        if isSearch {
            cellModelViewItemSearch.removeAll()
            cellModelViewItemSearch.append(contentsOf: aux)
        } else {
            cellModelViewItem.removeAll()
            cellModelViewItem.append(contentsOf: aux)
        }
    }
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return isSearch ? cellModelViewItemSearch.count:cellModelViewItem.count
    }
    
    func getCellViewModel(at indexPath: IndexPath ) -> ItemCitiesModelView {
        return isSearch ? cellModelViewItemSearch[indexPath.row]: cellModelViewItem[indexPath.row]
    }
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingNextStatus: (()->())?
}
