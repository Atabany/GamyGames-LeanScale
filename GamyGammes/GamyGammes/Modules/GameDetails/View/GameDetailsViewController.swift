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
    var redditButton = ButtonView(title: "Visit reddit", hasBottomDivider: false)
    var websiteButton = ButtonView(title: "Visit website", hasBottomDivider: true)
    
    var activityIndicator = UIActivityIndicatorView()
    var favoriteButton = UIBarButtonItem()
    
    var padding: CGFloat = 16
    
    
    var descriptionAttributedText: NSAttributedString?
    
    var viewModel: GameDetailsViewModel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
}


extension GameDetailsViewController {
    private func setup() {
        configureNavBar()
        initVM()
        configureButtonActions()
    }
    
    func configureNavBar() {
        favoriteButton = UIBarButtonItem(title: viewModel.favoruiteButtonTitle, style: .plain, target: self, action: #selector(favoriteButtonAction(_:)))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    
    func configureButtonActions() {
        
        redditButton.isUserInteractionEnabled = true
        redditButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redditButtonAction)))
        
        
        websiteButton.isUserInteractionEnabled = true
        websiteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteButtonAction)))
        
    }
    
}
extension GameDetailsViewController {
    
    func initVM() {
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.scrollView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.scrollView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.scrollView.alpha = 1.0
                    })
                }
            }
        }


        viewModel.showDetails = { [weak self] () in
            guard let self = self else {return}
            self.updateUI()
        }
        
        
        viewModel.openReddit = { [weak self] in
            guard let self = self else {return}
            guard let url = URL(string: self.viewModel.redditURL) else { return }
            self.presentSafariVC(with: url)
        }
        
        
        viewModel.openWebsite = { [weak self] in
            guard let self = self else {return}
            guard let url = URL(string: self.viewModel.website) else { return }
            self.presentSafariVC(with: url)
        }
        
        
        
        viewModel.updateFavoriteButton = { [weak self] in
            guard let self = self else {return}
            self.favoriteButton.title = self.viewModel.favoruiteButtonTitle
        }
        
        viewModel.initFetch()
    }
    
}

extension GameDetailsViewController {
    private func style() {
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        styleTitleLabel()
        styleBackgroundImage()
        styleDescriptionKeyLabel()
        styleDescriptionValueLabel()
        styleButtonsStackView()
    }
    
    
    private func styleActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator =  UIActivityIndicatorView(style: .large)
        }
    }
    
    private func styleTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font  = UIFont(name: "SFProDisplay-Bold", size: 36)
        titleLabel.text = "Grand Theft Auto V"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
    
    
    private func styleBackgroundImage() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.image = Constants.Images.logo
        backgroundImage.addoverlay()
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
        descriptionAttributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        valueGameDescriptionLabel.attributedText = descriptionAttributedText
        
        
    }
    
    
    private func styleButtonsStackView() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 0
        buttonsStackView.alignment = .leading
        buttonsStackView.distribution = .fill
    }
    
    
    
}


extension GameDetailsViewController {
    private func layout() {
        layoutScrollView()
        layoutBackgroundImage()
        layoutTitleLabel()
        layoutKeyDescriptionLabel()
        layoutValueDescriptionLabel()
        layoutButtons()
        layoutActivityIndicator()
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
            backgroundImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor) ,
            backgroundImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ])
    }
    
    
    private func layoutTitleLabel() {
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -padding),
        ])
    }
    
    private func layoutKeyDescriptionLabel() {
        scrollView.addSubview(keyGameDescriptionLabel)
        NSLayoutConstraint.activate([
            keyGameDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            keyGameDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            keyGameDescriptionLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: padding),
            keyGameDescriptionLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    
    private func layoutValueDescriptionLabel() {
        scrollView.addSubview(valueGameDescriptionLabel)
        NSLayoutConstraint.activate([
            valueGameDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            valueGameDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            valueGameDescriptionLabel.topAnchor.constraint(equalTo: keyGameDescriptionLabel.bottomAnchor, constant: padding),
            
        ])
    }
    
    
    
    private func layoutButtons() {
        scrollView.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(redditButton)
        buttonsStackView.addArrangedSubview(websiteButton)
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            buttonsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: valueGameDescriptionLabel.bottomAnchor, constant: (padding * 2)),
            buttonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -(padding * 4))
        ])
    }
    
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    
}


//MARK: - Actioins
extension GameDetailsViewController {
    @objc
    func favoriteButtonAction(_ sender: UIBarButtonItem) {
        viewModel.addGameToFavorite()
    }
    
    
    @objc
    func redditButtonAction() {
        viewModel.pressReddit()
    }
    

    
    @objc
    func websiteButtonAction() {
        viewModel.pressVisitWebsite()
    }
    
}


extension GameDetailsViewController {
    
    func updateUI() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.viewModel.titleText
            self.valueGameDescriptionLabel.text = self.viewModel.description
            self.backgroundImage.setImage(from: self.viewModel.backgroundImageURL)
        }
    }
}
