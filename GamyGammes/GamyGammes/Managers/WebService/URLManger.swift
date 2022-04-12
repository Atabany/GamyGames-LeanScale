//
//  URLManger.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation



struct URLManager {

    private init() {}
    static let shared: URLManager = URLManager()
    
    var pageSize = 10

    
    private var baseGitHubURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.rawg.io"
        return urlComponents
    }

    
    func GamesURL(with path: String, query: [String: String]? = nil) -> URL? {
        var urlComponents = baseGitHubURL
        urlComponents.path = path
        
        if let query = query {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in query {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponents.queryItems = queryItems
        }
        return urlComponents.url
    }
    
    

 
    

}

