//
//  UIView+Ext.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subivews: UIView...) {
        subivews.forEach {addSubview($0)}
    }
    

    //This function will add a layer on any `UIView` to make that `UIView` look darkened
    func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
    
}
