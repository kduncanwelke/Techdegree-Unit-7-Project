//
//  Endpoint.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/2/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

enum Endpoint {
    case genre
    case actors
    case search
    
    private var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    private var key: String {
        return "APIKEY"
    }
    
    private var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/")!
    }
    
    func url() -> URL {
        switch self {
        case .genre:
            var components = URLComponents(url: baseURL.appendingPathComponent("genre/movie/list"), resolvingAgainstBaseURL: false)
            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(key)")]
            return components!.url!
        case .actors:
            var components = URLComponents(url: baseURL.appendingPathComponent("person/popular"), resolvingAgainstBaseURL: false)
            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(key)"), URLQueryItem(name: "page", value: "1")]
            return components!.url!
        case .search:
            var components = URLComponents(url: baseURL.appendingPathComponent("discover/movie"), resolvingAgainstBaseURL: false)
            
            let searchGenres = Viewer.getGenres(for: Viewer.viewer1) + Viewer.getGenres(for: Viewer.viewer2)
            let searchActors = Viewer.getActors(for: Viewer.viewer1) + Viewer.getActors(for: Viewer.viewer2)
            let searchRating = String(describing: (Viewer.viewer1.preferredMinimumRating + Viewer.viewer2.preferredMinimumRating) / 2)
            
            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(key)"), URLQueryItem(name: "with_genres", value: "\(searchGenres)"), URLQueryItem(name: "with_people", value: "\(searchActors)"), URLQueryItem(name: "vote_count.gte", value: "\(searchRating)")]
            return components!.url!
        }
    }
}

// let components = URLComponents(url: imageURL.appendingPathComponent("w185\(String(describing: poster))"), resolvingAgainstBaseURL: false)
// return components!.url!
