//
//  Genre.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/2/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct Genre: MovieType {
    let id: Int
    let name: String
    static var endpoint = Endpoint.genre
}
