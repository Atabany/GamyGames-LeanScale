//
//  MainTabBarController.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        viewControllers = [createGamesListNC(), createFavoritesNC()]
    }
    
    
    func configureAppearance() {
        UITabBar.appearance().tintColor = AppTheme.shared.tabBarTintColor
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor  = AppTheme.shared.tabBarBackgroundColor
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
    func createGamesListNC() -> UINavigationController {
        let searchVC = GamesListTableViewController()
        searchVC.viewModel = GamesListViewModel(apiService: GamesListWebService(), gamesListScreen: SearchGames())
        searchVC.tabBarItem = UITabBarItem(title: "Games", image:  Constants.Images.playIcon!, tag: 0)
        let searchNC = UINavigationController(rootViewController: searchVC)
        return searchNC
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoriteVC = GamesListTableViewController()
        favoriteVC.viewModel = GamesListViewModel(apiService: FavoritesGamesListService(), gamesListScreen: FavoriteGames())
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: Constants.Images.favoriteIcon!, tag: 1)
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        return favoriteNC
    }
    
    
}
