//
//  Resources.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    var method: NetworkMethod
    
    init(url: URL, method: NetworkMethod = .get) {
        self.url = url
        self.method = method
    }
}










