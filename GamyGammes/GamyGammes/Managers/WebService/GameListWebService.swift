//
//  GameListWebService.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation

struct GamesListWebService:  GamesListServiceProtcol {
    
    func loadData(page: Int, search: String? = nil, completion: @escaping (Result<([Game], String?), NetworkError>) -> ()) {
        
        var resource: Resource<GamesResponse>?
        
        if let search = search {
            resource = GameResources.searchGamesResoruce(page: page, search: search)
        } else {
            resource = GameResources.gamesListResoruce(page: page)
        }
        
        guard let resource = resource else {
            return
        }
        
        NetworkManager.shared.load(resource: resource ) { result in
            switch result {
            case .success(let gamesResponse):
                let games = gamesResponse.results ?? []
                let next = gamesResponse.next
                completion(.success((games, next)))
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



