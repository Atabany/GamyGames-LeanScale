//
//  GameDetails.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation

struct GameDetails: Codable {
    let id: Int?
    let redditURL: String?
    let website: String?
    let name: String?
    let gameDescription: String?
    let backgroundImage: String?
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage = "background_image"
        case gameDescription = "description"
        case name, id, website
        case redditURL = "reddit_url"
        
    }
    
}



