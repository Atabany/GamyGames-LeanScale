//
//  UIViewController + Ext.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//


import UIKit
import SafariServices

extension UIViewController {
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlert( _ message: String, callBack: @escaping ((UIAlertAction) -> ()) ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction( UIAlertAction(title: "Delete", style: .destructive, handler: callBack))
        self.present(alert, animated: true, completion: nil)
    }

}
extension UIViewController {
    
    func presentSafariVC(with url: URL) {
        let SFSafariViewController = SFSafariViewController(url: url)
        SFSafariViewController.preferredControlTintColor = .systemGreen
        present(SFSafariViewController, animated: true)
    }
    

}
