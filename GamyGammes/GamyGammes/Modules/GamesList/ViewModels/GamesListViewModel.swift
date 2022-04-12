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


protocol GamesListProtocl {
    var canDelete: Bool {get}
    var canSearch: Bool {get}
    var emptyMessage: String {get}
    var title: String {get}
    
}


struct SearchGames: GamesListProtocl {
    var canDelete: Bool = false
    var canSearch: Bool = true
    var emptyMessage: String = "No game has been searched."
    var title: String   = "Games"
}


struct FavoriteGames: GamesListProtocl {
    var canDelete: Bool = true
    var canSearch: Bool  = false
    var emptyMessage: String = "There is no favourites found."
    var favoriteCount: Int = 0
    var title: String   {
        if favoriteCount > 0 {
            return "Favorites (\(favoriteCount))"
        }
        return "Favorites"
    }
}



class GamesListViewModel {
    
    
    fileprivate var apiService: GamesListServiceProtcol!
    
    var gamesListScreen: GamesListProtocl!
    
    init(apiService: GamesListServiceProtcol, gamesListScreen: GamesListProtocl) {
        self.apiService = apiService
        self.gamesListScreen = gamesListScreen
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
    
    var alertWithHandlerMessage: String? {
        didSet {
            self.showAlertWithHandlerClosure?()
        }
    }

    
    
    
    
    var selectedGame: Game?
    
    lazy var navBarTitle = Dynamic(gamesListScreen.title)
    
    
    
    var emptyMessage: String {
        return gamesListScreen.emptyMessage
    }
    
    var canDelete: Bool {
        return gamesListScreen.canDelete
    }
    
    var canSearch: Bool {
        return gamesListScreen.canSearch
    }
    
    
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showDetails: (()->())?
    var showAlertWithHandlerClosure: (()->())?

    var selectedIndedxPathForDeletion: IndexPath?
    
    
    func initFetch() {
        state = .loading
        apiService.loadData(page: 1) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let games):
                self.processFetchedGames(games: games)
                self.updateFavoriteCount()
                self.setState()
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
        gameViewModels = vms
    }
    
    
    private func setState() {
        self.state = gameViewModels.count > 0 ? .populated : .empty
    }
    
    private func createCellViewModel( game: Game ) -> GameViewModel {
        return GameViewModel(game: game)
    }
    
    private func updateFavoriteCount() {
        if var gamesListScreen = gamesListScreen as? FavoriteGames {
            gamesListScreen.favoriteCount = gameViewModels.count
            self.gamesListScreen = gamesListScreen
            self.navBarTitle.value = gamesListScreen.title
        }
        
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
    
    func deleteFavoriteAt(indexPath: IndexPath) {
        self.selectedIndedxPathForDeletion = indexPath
        self.alertWithHandlerMessage = "Do you want to remove this game from favorite?"
    }
    
    func alertHandlerAction() {
        guard let selectedIndedxPathForDeletion = selectedIndedxPathForDeletion else {return}
        PersistenceManager.updateWith(favorite: games[selectedIndedxPathForDeletion.row], actionType: .remove) { [weak self] (favorite, error) in
            guard let self = self else {return}
            if let error = error {
                self.alertMessage = error.rawValue
                return
            }
            self.games.remove(at: selectedIndedxPathForDeletion.row)
            self.gameViewModels.remove(at: selectedIndedxPathForDeletion.row)
            
            self.updateFavoriteCount()

            if self.gameViewModels.isEmpty {
                self.state = .empty
                return
            }
        }

    }
    
    
    func search(filter: String) {
        
//        guard let filter = searchController.searchBar.text, (filter.count > 3) else {
//            viewModel.initFetch()
//            return
//        }
        
        
        
        
        
        let filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)

    }
    
}
