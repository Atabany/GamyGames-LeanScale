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
            // Fallback on earlier versions
        }
        window?.rootViewController = ViewController()
        
        return true
    }
    

    


}

