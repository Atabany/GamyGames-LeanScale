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


enum PersistenceError: String, Error {
    case unableToFavorite       = "Unable to favoriting the follower"
    case alreadyInFavorites     = "You've already favorited this user. you must REALY like them!"
    
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
    
    static func updateWith(favorite: Game, actionType: PersistenceActionType, completed: @escaping (PersistenceError?)->()) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {completed(.alreadyInFavorites); return}
                    favorites.append(favorite)
                    break
                case .remove:
                    favorites.removeAll {$0.id == favorite.id }
                    break
                }
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
                break
            }
        }
    }
    
    
    static  func retrieveFavorites(completed: @escaping (Result<[Game], PersistenceError>) -> ()) {
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder                     =  JSONDecoder()
            let favFollowers                =  try decoder.decode([Game].self, from: favoritesData)
            completed(.success(favFollowers))
            return
        } catch {
            completed(.failure(.unableToFavorite))
            return
        }
    }
    
    
    static private func save(favorites: [Game]) -> PersistenceError? {
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

