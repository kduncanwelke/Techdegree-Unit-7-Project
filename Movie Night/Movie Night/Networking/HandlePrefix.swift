//
//  HandlePrefix.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/4/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct HandlePrefix<T: Codable>: Codable {
    var genres: [T]?
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [T]?
}
