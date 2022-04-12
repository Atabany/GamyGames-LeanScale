//
//  GamesListViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

protocol GamesListServiceProtcol {
    func loadData(page: Int, completion: @escaping (Result<[Game], NetworkError>)->())
}



class GamesListViewModel {
    

    fileprivate var apiService: GamesListServiceProtcol!
    
    init(apiService: GamesListServiceProtcol) {
        self.apiService = apiService
    }
    
    var games: [Game] = []
    var gameViewModels: [GameViewModel] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    

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

    
    var selectedGame: Game?

    var navBarTitle: String {
        return "Games"
    }

    
    var emptyMessage: String = "No game has been searched."
    

    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showDetails: (()->())?

    
    
    
    func initFetch() {
        state = .loading
        apiService.loadData(page: 1) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let games):
                self.processFetchedGames(games: games)
                self.state = .populated
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue

            }
        }
    }
    
    
    private func processFetchedGames( games: [Game] ) {
        self.games = games // Cache
        var vms = [GameViewModel]()
        for game in games {
            vms.append( createCellViewModel(game: game) )
        }
        self.gameViewModels = vms
    }
    
    
    func createCellViewModel( game: Game ) -> GameViewModel {
        return GameViewModel(game: game)
    }
    
}



extension GamesListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    
    func numberOfRowsIn(section: Int) -> Int {
        return gameViewModels.count
    }
    
    func gameViewModelAt(indexPath: IndexPath) -> GameViewModel? {
        
        guard indexPath.row < gameViewModels.count else {
            return nil
        }
        return gameViewModels[indexPath.row]
    }
    
    
    func didSelectViewModel(at indexPath: IndexPath) {
        guard indexPath.row < gameViewModels.count else {
            return
        }
        selectedGame = gameViewModels[indexPath.row].game
        self.showDetails?()
    }
}


