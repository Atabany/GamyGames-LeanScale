//
//  GameResources.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation

enum APIGamesURLs {
    static func gamesDefaultURL(page: Int) -> URL? {
        return URLManager.shared.GamesURL(with: "/api/games", query: [
            "page_size": "\(URLManager.shared.pageSize)",
            "page" : "\(page)",
            "key"  : "3be8af6ebf124ffe81d90f514e59856c"
        ])
    }
    
    
    static func gameDetails(gameId: Int) -> URL? {
        return URLManager.shared.GamesURL(with: "/api/games/\(gameId)", query: [
            "key"  : "3be8af6ebf124ffe81d90f514e59856c"
        ])
    }

    
}


struct GameResources {
    static func gamesListResoruce(page: Int) -> Resource<GamesResponse>? {
        guard let url = APIGamesURLs.gamesDefaultURL(page: page) else { return nil }
        return Resource<GamesResponse>(url: url)
    }
    
    
    static func gamesDetailsResoruce(id: Int) -> Resource<GameDetails>? {
        guard let url = APIGamesURLs.gameDetails(gameId: id) else { return nil }
        return Resource<GameDetails>(url: url)
    }

}
