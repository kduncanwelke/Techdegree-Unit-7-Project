//
//  DataManager.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/3/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation

struct DataManager<T: MovieType> {
    private static func fetch(url: URL, completion: @escaping (Result<HandlePages<T>>) -> Void) {
        Networker.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder.TMDBDecoder.decode(HandlePages<T>.self, from: data) else {
                    return
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetch(with page: Int, completion: @escaping (Result<[T]>) -> Void) {
        fetch(url: T.endpoint.url(page: page)) { result in
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
        func handle(result: Result<HandlePages<T>>) {
            switch result {
            case .success(let response):
                if let genres = response.genres {
                    resultArray.append(contentsOf: genres)
                    completion(.success(resultArray))
                } else if let results = response.results {
                     resultArray.append(contentsOf: results)
                    if response.page == 1 {
                        fetch(url: T.endpoint.url(page: 2), completion: handle)
                    }
                    completion(.success(resultArray))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        fetch(url: T.endpoint.url(page: 1), completion: handle)
    }
    
}
