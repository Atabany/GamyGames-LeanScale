//
//  Persistence.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}





enum PersistenceManager {
    

    
    static private let  defaults = UserDefaults.standard
    
    enum keys {
        static let favorites = "favorites"
    }
    
    
    
    static func removeAll() {
        defaults.removeObject(forKey: "favorites")
    }
    
    
    static func isThisGameAlreadyFavorited(game: Game, completed: @escaping (Bool)->())  {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                completed( favorites.contains(game))
            case .failure:
                break
            }
        }
    }
    
    static func updateWith(favorite: Game, actionType: PersistenceActionType, completed: @escaping ([Game] ,NetworkError?)->()) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {completed(favorites,.alreadyInFavorites); return}
                    favorites.append(favorite)
                    break
                case .remove:
                    favorites.removeAll {$0.id == favorite.id }
                    break
                }
                completed(favorites, save(favorites: favorites))
            case .failure(let error):
                completed([],error)
                break
            }
        }
    }
    
    
    static  func retrieveFavorites(completed: @escaping (Result<[Game], NetworkError>) -> ()) {
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder                     =  JSONDecoder()
            let favGames                    =  try decoder.decode([Game].self, from: favoritesData)
            completed(.success(favGames))
            return
        } catch {
            completed(.failure(.unableToFavorite))
            return
        }
    }
    
    
    static private func save(favorites: [Game]) -> NetworkError? {
        do {
            let encoder         = JSONEncoder()
            let data            =  try encoder.encode(favorites)
            defaults.set(data, forKey: keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    
}



struct FavoritesGamesListService: GamesListServiceProtcol {
    func loadData(page: Int, completion: @escaping (Result<[Game], NetworkError>) -> ()) {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                completion(.success(favorites))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
}
