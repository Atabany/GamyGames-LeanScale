//
//  GameListProtocol.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation
protocol GamesListServiceProtcol {
    func loadData(page: Int, search: String? , completion: @escaping (Result<([Game], String?), NetworkError>)->())
}


protocol GamesListProtocl {
    var canDelete: Bool {get}
    var canSearch: Bool {get}
    var emptyMessage: String {get}
    var title: String {get}
    
}


struct SearchGames: GamesListProtocl {
    var canDelete: Bool = false
    var canSearch: Bool = true
    var emptyMessage: String = Constants.Strings.emptyMessageSearch
    var title: String   = Constants.Strings.games
}


struct FavoriteGames: GamesListProtocl {
    var canDelete: Bool = true
    var canSearch: Bool  = false
    var emptyMessage: String = Constants.Strings.emptyMessageFavorite
    var favoriteCount: Int = 0
    var title: String   {
        if favoriteCount > 0 {
            return "\(Constants.Strings.favorites) \(favoriteCount))"
        }
        return Constants.Strings.favorites
    }
}
