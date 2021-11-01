//
//  Country.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation
import RealmSwift

@objcMembers class Country: Object, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case created_at
        case updated_at
        case continent_id
    }
    
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var created_at: String?
    @Persisted var updated_at: String?
    @Persisted var continent_id: Int?
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.continent_id = try container.decodeIfPresent(Int.self, forKey: .continent_id)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.code, forKey: .code)
        try container.encodeIfPresent(self.created_at, forKey: .created_at)
        try container.encodeIfPresent(self.updated_at, forKey: .updated_at)
        try container.encodeIfPresent(self.continent_id, forKey: .continent_id)
    }
    
    required override init() {
        super.init()
    }
}
