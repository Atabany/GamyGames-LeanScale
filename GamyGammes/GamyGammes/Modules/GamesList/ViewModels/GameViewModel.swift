//
//  GameViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation
struct GameViewModel {
    var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    
    var title: String {
        return game.name ?? ""
    }
    
    var generesText: String {
        return game.genres?.compactMap(\.name).joined(separator: " , ") ?? ""
    }
    
    var imageURL: String {
        return game.backgroundImage ?? ""
    }
    
    
    var ratingText: String {
        return String(game.metacritic ?? 0)
    }
    
    
}
