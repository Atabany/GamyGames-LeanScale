//
//  GameDetailsViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation

protocol GameDetailsApiServiceProtocol {
    func loadData(id: Int, completion: @escaping (Result<GameDetails, NetworkError>)->())
}

class GameDetailsViewModel {
    
    private var gameId: Int
    var selectedGame: Game?
    private var apiService: GameDetailsApiServiceProtocol!
    
    
    init(service: GameDetailsApiServiceProtocol, selectedGame: Game?) {
        self.apiService = service
        self.gameId = selectedGame?.id ?? 0
        self.selectedGame = selectedGame
        self.checkGameFavorited()
    }

    
    
    var showDetails: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var openWebsite: (()->())?
    var openReddit: (()->())?
    var updateFavoriteButton: (()->())?

    
    
    // callback for interfaces
    
    private var gameDetails: GameDetails? {
        didSet {
            showDetails?()
        }
    }

    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    
    func initFetch() {
        state = .loading
        apiService.loadData(id: gameId) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let gameDetails):
                self.gameDetails = gameDetails
                self.state =  .populated
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue
            }
        }
    }

    
    var backgroundImageURL: String {
        return gameDetails?.backgroundImage ?? ""
    }
    
    var titleText: String {
        return gameDetails?.name ?? ""
    }
    
    var description: String {
        return (gameDetails?.gameDescription ?? "").html2String
    }
    
    
    var redditURL: String {
        return gameDetails?.redditURL ?? ""
    }
    
    var website: String {
        return gameDetails?.website ?? ""
    }
    
    var favoruiteButtonTitle: String? {
        didSet {
            updateFavoriteButton?()
        }
    }
    
    var isFavorited: Bool = false {
        didSet {
            self.favoruiteButtonTitle =  isFavorited ?  "Favorited" : "Favorite"
        }
    }
    
    
    func pressReddit() {
        self.openReddit?()
    }
    
    
    func pressVisitWebsite() {
        self.openWebsite?()
    }
    
    
    func checkGameFavorited()  {
        guard let selectedGame = self.selectedGame else {return}
        PersistenceManager.isThisGameAlreadyFavorited(game: selectedGame) { isFavorited in
            self.isFavorited = isFavorited
        }
    }
    
}


//MARK: -  Persistence / Favorite
extension GameDetailsViewModel {
    func addGameToFavorite() {
        guard let selectedGame = self.selectedGame else {return}
        PersistenceManager.updateWith(favorite: selectedGame, actionType: .add) { [weak self] (favorite ,error) in
            guard let self = self else {return}
            guard  error == nil else {
                self.alertMessage = error?.rawValue
                return
            }
            self.alertMessage = "Added To Favorite 🎉"
            self.checkGameFavorited()
            return
        }
    }
}
