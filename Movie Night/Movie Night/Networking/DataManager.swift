//
//  DataManager.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/3/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct DataManager<T: MovieType> {
    private static func fetch(url: URL, completion: @escaping (Result<HandlePrefix<T>>) -> Void) {
        Networker.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.TMDBDecoder.decode(HandlePrefix<T>.self, from: data) else {
                    print("fail")
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    
    }
    
    static func fetch(completion: @escaping (Result<[T]>) -> Void) {
        fetch(url: T.endpoint.url(page: 1)) { result in
            switch result {
            case .success(let result):
                if let genres = result.genres {
                    completion(.success(genres))
                } else if let results = result.results {
                    completion(.success(results))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getData(completion: @escaping (Result<[T]>) -> Void) {
        var resultArray = [T]()
        func handle(result: Result<HandlePrefix<T>>) {
            switch result {
            case .success(let response):
                if let genres = response.genres {
                     resultArray.append(contentsOf: genres)
                } else if let results = response.results {
                     resultArray.append(contentsOf: results)
                    if response.totalPages != nil {
                        fetch(url: T.endpoint.url(page: 2), completion: handle)
                    }
                } else {
                    completion(.success(resultArray))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        fetch(url: T.endpoint.url(page: 1), completion: handle)
    }
    
}
