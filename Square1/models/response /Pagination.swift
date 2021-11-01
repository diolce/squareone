//
//  Pagination.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation
import RealmSwift

class Pagination: Object, Codable {
    enum CodingKeys: String, CodingKey {
        case current_page
        case last_page
        case per_page
        case total
    }
    
    @Persisted var current_page:Int?
    @Persisted var last_page:Int?
    @Persisted var per_page:Int?
    @Persisted var total: Int?
    
    // MARK: - Decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.current_page = try container.decodeIfPresent(Int.self, forKey: .current_page)
        self.last_page = try container.decodeIfPresent(Int.self, forKey: .last_page)
        self.per_page = try container.decodeIfPresent(Int.self, forKey: .per_page)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        super.init()
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.current_page, forKey: .current_page)
        try container.encodeIfPresent(self.last_page, forKey: .last_page)
        try container.encodeIfPresent(self.per_page, forKey: .per_page)
        try container.encodeIfPresent(self.total, forKey: .total)
    }
    
    required override init() {
        super.init()
    }
    
}
