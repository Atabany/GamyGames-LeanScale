//
//  GameDetailsViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation

protocol GameDetailsApiServiceProtocol {
    func loadData(id: Int, completion: @escaping (Result<Game, NetworkError>)->())

}

class GameDetailsViewModel {
    
    var service: GameDetailsApiServiceProtocol
    var gameId: Int
    
    init(service: GameDetailsApiServiceProtocol, gameId: Int) {
        self.service = service
        self.gameId = gameId
    }
    
    
    
}
