//
//  GamesListViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

protocol GamesListService {
    func loadData(completion: @escaping (Result<[GameViewModel], NetworkError>)->())
}



struct GamesListViewModel {
    
    var gameViewModels: [GameViewModel] = [] {
        didSet {
            self.reloadTableColsure?()
        }
    }
    
    fileprivate var service: GamesListService!

    var reloadTableColsure: (()->())?
    
    
    var title: String {
        return "Games"
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


