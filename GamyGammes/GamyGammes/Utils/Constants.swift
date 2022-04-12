//
//  Constants.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation
import UIKit


enum Constants {
        
    enum TableCellsIdentifier {
        static let unitTableCell = "unitTableCell"
    }
    
    enum Images {
        static let logo = UIImage(named: "logo")
        static let playIcon = UIImage(named: "PlayIcon")
        static let favoriteIcon = UIImage(named: "FavoriteIcon")
    }
    
    
    enum Strings {
        
        static let emptyMessageSearch: String = "No game has been searched."
        static let emptyMessageFavorite: String = "There is no favourites found."
        static let games: String = "Games"
        static let favorites: String = "Favorites"
        static let deletAlertMessage: String = "Do you want to remove this game from favorite?"

        static let searchForTheGame = "Search for the games"
        

    }
}

