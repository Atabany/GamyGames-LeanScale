//
//  WebService.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit


enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}


enum NetworkError: String, Error {
    
    case badStuffHappend        = "Bad Stuff Happened"
    case somethingWentWrong     = "Something went wrong"
    case invalidURL             = "This url  is  invalid . Please try again."
    case unableToComplete       =  "unable to complete your request. please check your internet connection"
    case invalidResponse        = "Invalid Response from the server please try again."
    case invalidData            = "The data received from the server is invalid, please try again."
    case requestNotCompleted    = "Request not completed please try again"
    
    
}


class NetworkManager {
    
    static let shared   = NetworkManager()
    let cashe           = NSCache<NSString, UIImage>()
    let decoder         =  JSONDecoder()
    
    private init() {}
    
    
    
    
    
    
    
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue
        //        if let body = resource.body {
        //            request.httpBody = body
        //        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidURL))
                return
            }
            
            if let result = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(.invalidResponse))
            }
            
        }.resume()
        
    }
    
    
    
    
    
}



extension NetworkManager {
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> ())  {
        let casheKey = NSString(string: urlString)
        if let image = cashe.object(forKey: casheKey) { completion(image); return}
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self else {return}
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.cashe.setObject(image, forKey: casheKey)
            completion(image)
            return
        }.resume()
    }
}





