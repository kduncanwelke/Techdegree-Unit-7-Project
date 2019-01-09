//
//  Viewer.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/8/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct Viewer {
    var preferredGenres: [Genre]
    var preferredActors: [Actor]
    var preferredMinimumRating: Int
    
    static var viewer1 = Viewer(preferredGenres: [], preferredActors: [], preferredMinimumRating: 0)
    static var viewer2 = Viewer(preferredGenres: [], preferredActors: [], preferredMinimumRating: 0)
    
    static var hasViewer1Selected = false
    static var hasViewer2Selected = false
    
    enum CurrentlySelected {
        case viewer1, viewer2, none
    }
    
    static var currentlySelected = CurrentlySelected.none
}

