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
    private var gameDetails: GameDetails? {
        didSet {
            showDetails?()
        }
    }
    
    
    private var apiService: GameDetailsApiServiceProtocol!

    
    var showDetails: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var openWebsite: (()->())?
    var openReddit: (()->())?

    
    

    // callback for interfaces
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

    
    
    init(service: GameDetailsApiServiceProtocol, gameId: Int) {
        self.apiService = service
        self.gameId = gameId
    }
    
    func initFetch() {
        state = .loading
        apiService.loadData(id: gameId) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let gameDetails):
                self.gameDetails = gameDetails
                self.state = .populated
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
    
    func pressReddit() {
        self.openReddit?()
    }
    
    
    func pressVisitWebsite() {
        self.openWebsite?()
    }
    
    
    
}
