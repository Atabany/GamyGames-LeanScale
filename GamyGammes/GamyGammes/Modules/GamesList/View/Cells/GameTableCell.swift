//
//  GameTableCell.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import Foundation
import UIKit

class GameTableCell: UITableViewCell {

    
    static let reuseId = "GameTableCell"
    static let rowHeight: CGFloat = 112
    
    let padding: CGFloat = 16

    
    let gameImageView             = UIImageView()
    let titleLabel                = UILabel()
    let ratingValueLabel          = UILabel()
    let ratingKeyLabel            = UILabel()
    let generLabel                = UILabel()
    
    let containerLabelsStackView  = UIStackView()
    let ratingStackView           = UIStackView()
    let bottomStackView           = UIStackView()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        self.style()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    


    
}

extension GameTableCell {
    
    private func setup() {
        
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        
        
        [gameImageView,
        titleLabel,
        ratingValueLabel,
        ratingKeyLabel,
        generLabel,
        containerLabelsStackView,
        ratingStackView,
         bottomStackView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false }
        
        

        
        setupContainerLabelsStackView()
        setupBottomStackView()
        setupRatingStackView()
        
    }
    
    private func setupContainerLabelsStackView() {
        containerLabelsStackView.axis = .vertical
        containerLabelsStackView.distribution = .equalSpacing
        containerLabelsStackView.alignment = .leading
        
        containerLabelsStackView.addArrangedSubview(titleLabel)
        containerLabelsStackView.addArrangedSubview(bottomStackView)
        
    }
    
    
    private func setupBottomStackView() {
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 8
        
        bottomStackView.addArrangedSubview(ratingStackView)
        bottomStackView.addArrangedSubview(generLabel)
        
    }
    
    
    private func setupRatingStackView() {
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .fill
        ratingStackView.spacing = 3
        
        ratingStackView.addArrangedSubview(ratingKeyLabel)
        ratingStackView.addArrangedSubview(ratingValueLabel)
        
    }


    
    
    
    
    private func style() {
        styleImageView()
        styleTitleLabel()
        styleRatingKeyLabel()
        styleRatingValueLabel()
        styleGenreLabel()
        styleLabelsColorsHandleLowerVersions()
    }
    
    
    
    private func styleImageView() {
        gameImageView.image = Constants.Images.logo
    }
    
    private func styleTitleLabel() {
        titleLabel.text = "GTAAAAAGTAAAAAGTAAAAA GTAAAAAGTAAAAA GTAAAAAGTAAAAA GTAAAAA"
        titleLabel.font          = UIFont(name: "SFProDisplay-Bold", size: 20)
        titleLabel.numberOfLines = 2
    }
    
    private func styleRatingKeyLabel() {
        ratingKeyLabel.font      = UIFont(name: "SFProDisplay-Medium", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        ratingKeyLabel.attributedText = NSMutableAttributedString(string: "metacritic:", attributes: [NSAttributedString.Key.kern: 0.38, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    private func styleRatingValueLabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        ratingValueLabel.textAlignment = .right
        ratingValueLabel.attributedText = NSMutableAttributedString(string: "95", attributes: [NSAttributedString.Key.kern: 0.38, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        ratingValueLabel.textColor = UIColor(red: 216, green: 0, blue: 0, alpha: 1)
        ratingValueLabel.font    = UIFont(name: "SFProDisplay-Bold", size: 18)
    }
    
    private func styleGenreLabel() {
        generLabel.text      = "Action"
        generLabel.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.561, alpha: 1)
        generLabel.font      = UIFont(name: "SFProText-Regular", size: 13)
    }
    
    private func styleLabelsColorsHandleLowerVersions() {
        if #available(iOS 13.0, *) {
            titleLabel.textColor  = UIColor.label
            ratingKeyLabel.textColor = UIColor.label
        } else {
            titleLabel.textColor = .black
            ratingKeyLabel.textColor = .black
        }

    }
    
    
    
    
}

//MARK: -  Layout
extension GameTableCell {
    
    private func layout() {
        addSubviews(gameImageView, containerLabelsStackView)
        
        layoutImageView()
        layoutContainerLabelsStackView()
    }
    
    
    private func layoutImageView() {
        NSLayoutConstraint.activate([
            gameImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  padding),
            gameImageView.widthAnchor.constraint(equalToConstant: 120),
            gameImageView.heightAnchor.constraint(equalToConstant: 104),
        ])
    }
    
    
    
    private func layoutContainerLabelsStackView() {
        NSLayoutConstraint.activate([
            containerLabelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            containerLabelsStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: padding),
            containerLabelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            containerLabelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    
    
}
