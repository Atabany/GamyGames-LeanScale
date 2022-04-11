//
//  WebService.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation


enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var method: NetworkMethod
    var body: Data?
    
    init(url: URL, method: NetworkMethod = .get, body: Data? = nil) {
        self.url = url
        self.method = method
        self.body = body
    }
}






enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}


class WebService {
    
    
    static let shared: WebService = WebService()
    private init() {}
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue
        if let body = resource.body {
            request.httpBody = body
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            if let result = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
}


struct GamesListWebService:  GamesListServiceProtcol {
        func loadData(completion: @escaping (Result<[GameViewModel], NetworkError>) -> ()) {
//            WebService.shared.load(resource: resource) { result in
//            completion(result)
//        }
    }
}




