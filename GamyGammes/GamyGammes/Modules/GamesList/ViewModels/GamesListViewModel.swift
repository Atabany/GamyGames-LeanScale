//
//  GamesListViewModel.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit


struct GamesListViewModel {
    
    var gameViewModels: [GameViewModel] = [] {
        didSet {
            self.reloadTableColsure?()
        }
    }

    
    var reloadTableColsure: (()->())?
    
    

    
    
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
    
    var heightForRow: CGFloat {
        return 136
    }
    

    
}


