//
//  UIImageView+Ext.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

