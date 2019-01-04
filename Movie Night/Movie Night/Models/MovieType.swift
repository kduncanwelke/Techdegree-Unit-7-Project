//
//  MovieType.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/4/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

protocol MovieType: Codable {
    static var endpoint: Endpoint { get }
}
