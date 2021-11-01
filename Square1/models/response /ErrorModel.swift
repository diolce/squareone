//
//  ErrorModel.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 30/10/21.
//

import Foundation

struct ErrorModel: Codable, Error {
    var status: String
    var timeStamp: String
    var code: Int
    var message: String
}
