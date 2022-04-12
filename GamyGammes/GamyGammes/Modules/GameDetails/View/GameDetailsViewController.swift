//
//  GameDetailsViewController.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//

import Foundation
import UIKit


class GameDetailsViewController: UIViewController {
    
    var scrollView: UIScrollView = UIScrollView()
    var backgroundImage: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var keyGameDescriptionLabel = UILabel()
    var valueGameDescriptionLabel = UILabel()
    var buttonsStackView = UIStackView()
    var redditButton = UIButton()
    var websiteButton = UIButton()
    
    
    var padding: CGFloat = 16
    
    
    var descriptionAttributedText: NSAttributedString?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white
        style()
        layout()
    }
    
}


extension GameDetailsViewController {
    private func style() {
        styleTitleLabel()
        styleBackgroundImage()
        styleDescriptionKeyLabel()
        styleDescriptionValueLabel()
        styleButtons()
    }
    
    
    private func styleTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font  = UIFont(name: "SFProDisplay-Bold", size: 36)
        titleLabel.text = "Grand Theft Auto V"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
    }
    

    private func styleBackgroundImage() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.image = Constants.Images.logo

    }

    private func styleDescriptionKeyLabel() {
        keyGameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        keyGameDescriptionLabel.font  = UIFont(name: "SFProText-Regular", size: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        keyGameDescriptionLabel.attributedText = NSMutableAttributedString(string: "Game Description", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])


    }

    
    
    private func styleDescriptionValueLabel() {
        valueGameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        valueGameDescriptionLabel.font  = UIFont(name: "SFProText-Regular", size: 10)
        valueGameDescriptionLabel.lineBreakMode = .byWordWrapping
        valueGameDescriptionLabel.textColor =  UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        valueGameDescriptionLabel.numberOfLines = 4
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.84
        descriptionAttributedText = NSMutableAttributedString(string: "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate)....", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        valueGameDescriptionLabel.attributedText = descriptionAttributedText
        
        
    }
    
    
    private func styleButtons() {
        [redditButton, websiteButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.titleLabel?.font  = UIFont(name: "SFProText-Regular", size: 10)
            $0.titleLabel?.textColor =  UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 1.08
        
        redditButton.titleLabel?.attributedText = NSMutableAttributedString(string: "Visit reddit", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        websiteButton.titleLabel?.attributedText = NSMutableAttributedString(string: "Visit website", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
    }

    
    

    


    
    
}


extension GameDetailsViewController {
    
    
    private func layout() {
        layoutScrollView()
        layoutBackgroundImage()
        layoutTitleLabel()
        layoutKeyDescriptionLabel()
        layoutValueDescriptionLabel()
    }
    private func layoutScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func layoutBackgroundImage() {
        scrollView.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: 291),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor) ,
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    
    private func layoutTitleLabel() {
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -padding)
        ])
    }

    private func layoutKeyDescriptionLabel() {
        scrollView.addSubview(keyGameDescriptionLabel)
        NSLayoutConstraint.activate([
            keyGameDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            keyGameDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            keyGameDescriptionLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: padding),
            keyGameDescriptionLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func layoutValueDescriptionLabel() {
        scrollView.addSubview(valueGameDescriptionLabel)
        NSLayoutConstraint.activate([
            valueGameDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            valueGameDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            valueGameDescriptionLabel.topAnchor.constraint(equalTo: keyGameDescriptionLabel.bottomAnchor, constant: padding),
        ])
    }
    
    
    
//    private func layout() {
//        scrollView.addSubview(valueGameDescriptionLabel)
//        NSLayoutConstraint.activate([
//            valueGameDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            valueGameDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            valueGameDescriptionLabel.topAnchor.constraint(equalTo: keyGameDescriptionLabel.bottomAnchor, constant: padding),
//        ])
//    }
//
    

//    private func layoutValueDescriptionLabel() {
//        scrollView.addSubview(valueGameDescriptionLabel)
//        NSLayoutConstraint.activate([
//            valueGameDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            valueGameDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            valueGameDescriptionLabel.topAnchor.constraint(equalTo: keyGameDescriptionLabel.bottomAnchor, constant: padding),
//        ])
//    }
    
    



    

    

    
    
}
