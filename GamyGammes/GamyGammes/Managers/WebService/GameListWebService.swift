//
//  GameListWebService.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation

struct GamesListWebService:  GamesListServiceProtcol {
    func loadData(page: Int, completion: @escaping (Result<[Game], NetworkError>) -> ()) {
        guard let resource = GameResources.gamesListResoruce(page: page) else {
            completion(.failure(.invalidURL))
            return
        }
        
        NetworkManager.shared.load(resource: resource) { result in
            switch result {
            case .success(let gamesResponse):
                let games = gamesResponse.results ?? []
                completion(.success(games))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}




struct GamesDetailsWebService:  GameDetailsApiServiceProtocol {
    func loadData(id: Int, completion: @escaping (Result<GameDetails, NetworkError>) -> ()) {
        guard let resource = GameResources.gamesDetailsResoruce(id: id) else {
            completion(.failure(.invalidURL))
            return
        }
        print(id)
        print(resource.url)
        NetworkManager.shared.load(resource: resource) { result in
            switch result {
            case .success(let gameDetails):
                completion(.success(gameDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
}



