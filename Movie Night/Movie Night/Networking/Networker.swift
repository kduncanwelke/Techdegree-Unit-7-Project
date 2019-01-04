//
//  Networker.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/2/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct Networker {
    private static let session = URLSession(configuration: .default)
    
    static func getURL(endpoint: URL, completion: @escaping (Result<Data>) -> Void) {
        fetchData(url: endpoint, completion: completion)
    }
    
    static func fetchData(url: URL, completion: @escaping (Result<Data>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
