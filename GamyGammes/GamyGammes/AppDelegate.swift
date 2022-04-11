//
//  AppDelegate.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.backgroundColor = .systemBackground
        } else {
            window?.backgroundColor = .white
        }
        window?.rootViewController = UINavigationController(rootViewController:  GamesListTableViewController())
        setupNavigationBarStyle()
        
        return true
    }
    

    private func setupNavigationBarStyle() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = AppTheme.shared.navigationBarColor
            appearance.titleTextAttributes = [.foregroundColor: AppTheme.shared.navBarTitleColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: AppTheme.shared.navBarTitleColor]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance

        } else {
            UINavigationBar.appearance().barTintColor = AppTheme.shared.navigationBarColor
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: AppTheme.shared.navBarTitleColor]
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: AppTheme.shared.navBarTitleColor]
            UINavigationBar.appearance().isTranslucent = false
            
            
        }
    }




}

