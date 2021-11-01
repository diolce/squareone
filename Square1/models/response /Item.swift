//
//  Item.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation
import Realm
import RealmSwift

@objcMembers class Item: Object, Codable {
    /*let id: Int?
    let name: String?
    let local_name: String?
    let lat:Double?
    let lng: Double?
    let created_at: String?
    let updated_at: String?
    let country_id: Int?
    let country: Country?*/
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case local_name
        case lat
        case lng
        case created_at
        case updated_at
        case country_id
        case country
    }
    
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var local_name: String?
    @Persisted var lat:Double?
    @Persisted var lng: Double?
    @Persisted var created_at: String?
    @Persisted var updated_at: String?
    @Persisted var country_id: Int?
    @Persisted var country: Country?
    
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.local_name = try container.decodeIfPresent(String.self, forKey: .local_name)
        self.lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        self.lng = try container.decodeIfPresent(Double.self, forKey: .lng)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.country_id = try container.decodeIfPresent(Int.self, forKey: .country_id)
        self.country = try container.decodeIfPresent(Country.self, forKey: .country)
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.local_name, forKey: .local_name)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lng, forKey: .lng)
        try container.encode(self.created_at, forKey: .created_at)
        try container.encode(self.updated_at, forKey: .updated_at)
        try container.encode(self.country_id, forKey: .country_id)
        try container.encode(self.country, forKey: .country)
    }
    
    required override init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
