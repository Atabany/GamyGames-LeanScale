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
    
    var service: GameDetailsApiServiceProtocol
    var gameId: Int
    var gameDetails: GameDetails?
    
    
    fileprivate var apiService: GameDetailsApiServiceProtocol!

    
    var showDetails: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    
    

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
        self.service = service
        self.gameId = gameId
    }
    
    func initFetch() {
        state = .loading
        apiService.loadData(id: 1) { [weak self] result in
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
        // FIX: - Description
        return gameDetails?.name ?? ""
    }
    
    
    var redditURL: String {
        return gameDetails?.name ?? ""

//        return gameDetails.redditURL ?? ""
    }
    
    var website: String {
        return gameDetails?.name ?? ""

//        return gameDetails.websiteURL ?? ""
    }
    
    func pressReddit() {
    
//            guard let url = URL(string: ) else {
//                return
//            }
//            presentSafariVC(with: url)
//        }

    }
    
    
    func pressVisitWebsite() {
        
        
    }
    
    
    
}
