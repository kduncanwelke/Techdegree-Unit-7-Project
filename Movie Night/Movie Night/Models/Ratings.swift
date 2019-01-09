//
//  Ratings.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/8/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct Rating {
    let title: String
    let value: Int
    
    static let ratingPercentages = [Rating(title: "100%", value: 10), Rating(title: "90%", value: 9), Rating(title: "80%", value: 8), Rating(title: "70%", value: 7), Rating(title: "60%", value: 6), Rating(title: "50%", value: 5), Rating(title: "40%", value: 4), Rating(title: "30%", value: 3), Rating(title: "20%", value: 2), Rating(title: "10%", value: 1)]
}
