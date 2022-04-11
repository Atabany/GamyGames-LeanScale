//
//  AppTheme.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

enum Theme {
    case standard
}


struct AppTheme {
    
    static let shared: AppTheme = AppTheme()
    private init() {}
    
    var theme: Theme = .standard
    
    var navigationBarColor : UIColor   {
        switch theme {
        case .standard:
            return UIColor(red: 248, green: 248, blue: 248, alpha: 0.92)
        }
    }
    
    
    var navBarTitleColor : UIColor   {
        switch theme {
        case .standard:
            return .black
        }
    }
    
    
    
    var navBarTintColor : UIColor   {
        switch theme {
        case .standard:
            return .black
        }
    }
    
    var gamesBackgroundColor: UIColor{
        switch theme {
        case .standard:
            return UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        }
    }
    
}




