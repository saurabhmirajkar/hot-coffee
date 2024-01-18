//
//  Webservices.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 18/01/24.
//

import Foundation

enum NetworkError: Error {
    case decodingError, domainError, urlError
}

struct Resource<T:Codable> {
    let url: URL
}


class Webservices {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
