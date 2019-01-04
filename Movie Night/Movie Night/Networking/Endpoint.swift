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
    
    private var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    private var key: String {
        return "APIKEY"
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
        }
    }
}

