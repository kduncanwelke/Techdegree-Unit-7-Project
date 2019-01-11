//
//  MovieSearch.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/9/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct MovieSearch: MovieType {
    let title: String
    let posterPath: String
    static var endpoint = Endpoint.search
}
