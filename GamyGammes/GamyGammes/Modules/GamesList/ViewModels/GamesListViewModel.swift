//
//  GamesListViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation

class GamesListViewModel {
    
    
    private var apiService: GamesListServiceProtcol!
    var gamesListScreen: GamesListProtocl!
    
    init(apiService: GamesListServiceProtcol, gamesListScreen: GamesListProtocl) {
        self.apiService = apiService
        self.gamesListScreen = gamesListScreen
    }
    
    var games: [Game] = []
    
    // Pagination
    var next: String?
    var page = 1
    
    
    lazy var navBarTitle = Dynamic(gamesListScreen.title)
    
    
    // callback for interfaces
    var gameViewModels: [GameViewModel] = [] {
        didSet {
            self.reloadTableViewClosure?()
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
    
    var alertWithHandlerMessage: String? {
        didSet {
            self.showAlertWithHandlerClosure?()
        }
    }
    
    
    var selectedGame: Game?
    
    // Search
    var searchText: String? = nil
    
    
    
    
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
    
}

//MARK: - Fetch Data

extension GamesListViewModel {
    
    
    func initFetch() {
        state = .loading
        loadData(page: 1, loadMore: false)
    }
    
    func loadMore() {
        guard state != .loading else {return}
        guard next != nil else {return}
        state = .loading
        self.page += 1
        loadData(page: page, loadMore: true)
    }
    
    
    func loadData(page: Int, loadMore: Bool) {
        apiService.loadData(page: 1, search: searchText) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success((let games, let next)):
                loadMore ? self.processMoreFetchedGames(games: games) : self.processFetchedGames(games: games)
                self.updateFavoriteCount()
                self.setState()
                self.next = next
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
    
    private func processMoreFetchedGames( games: [Game] ) {
        self.games += games // Cache
        var vms = [GameViewModel]()
        for game in games {
            vms.append( createCellViewModel(game: game) )
        }
        gameViewModels += vms
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


//MARK: -  Table Data source & delegate

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
        self.alertWithHandlerMessage = Constants.Strings.deletAlertMessage
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
        guard filter.count > 3 else {return}
        self.searchText = filter
        self.initFetch()
    }
    
}
