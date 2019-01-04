//
//  Actor.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/3/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct Actor: MovieType {
    let id: Int
    let name: String
    static var endpoint = Endpoint.actors
}
