//
//  GameDetails.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation

struct GameDetails: Codable {
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
