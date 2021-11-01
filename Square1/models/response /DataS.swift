//
//  DataS.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation
import RealmSwift

@objcMembers class DataS: Object, Codable {
    //let items: [Item]?
    //let pagination: Pagination?
    
    enum CodingKeys: String, CodingKey {
        case items
        case pagination
    }
    
    // MARK: - Core Data Managed Object
    //@objc dynamic var items: [Item]?
    @Persisted var pagination: Pagination?
    // Realm List.
    @Persisted var items = RealmSwift.List<Item>()
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let list_items = try container.decodeIfPresent([Item].self, forKey: .items)
        if let itemsR = list_items { self.items.append(objectsIn: itemsR) }
        self.pagination = try container.decodeIfPresent(Pagination.self, forKey: .pagination)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.items, forKey: .items)
        try container.encode(self.pagination, forKey: .pagination)
    }
    
    required override init() {
        super.init()
    }
}






