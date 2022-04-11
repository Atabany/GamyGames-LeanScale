//
//  GamesListViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

protocol GamesListServiceProtcol {
    func loadData(completion: @escaping (Result<[GameViewModel], NetworkError>)->())
}



class GamesListViewModel {
    
    
    fileprivate var apiService: GamesListServiceProtcol!

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

    
    func initFetch() {
        state = .loading
    }
    
    
    
}



extension GamesListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    
    func numberOfRowsIn(section: Int) -> Int {
        return 10
//        return gameViewModels.count
    }
    
    func gameViewModelAt(indexPath: IndexPath) -> GameViewModel? {
        
        guard indexPath.row < gameViewModels.count else {
            return nil
        }
        return gameViewModels[indexPath.row]
    }
    
    

    
}


