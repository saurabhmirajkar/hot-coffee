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
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
struct Resource<T:Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
}

class Webservices {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
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
