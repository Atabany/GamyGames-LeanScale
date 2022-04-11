//
//  Game.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Game]?
}


struct Game: Codable {
        let id: Int?
        let name: String?
        let backgroundImage: String?
        let metacritic: Int?
        let genres: [Genre]?

        enum CodingKeys: String, CodingKey {
            case backgroundImage = "background_image"
            case id, name, metacritic, genres
        }
}


// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}



