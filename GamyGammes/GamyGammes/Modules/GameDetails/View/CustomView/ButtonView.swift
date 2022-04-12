//
//  ButtonView.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 12/04/2022.
//


import UIKit
class ButtonView: UIView {
    
    let dividerTopView = UIView()
    let dividerBottomView = UIView()
    let titleLabel = UILabel()
    
    var hasBottomDivider: Bool = false
    
    
    convenience init(title: String, hasBottomDivider: Bool) {
        self.init(frame: .zero)
        styleLabel(title: title)
        self.hasBottomDivider = hasBottomDivider
        styleBottomDivider()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 54)
    }
    
    
}


extension ButtonView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        dividerTopView.backgroundColor = UIColor.black
        dividerTopView.translatesAutoresizingMaskIntoConstraints = false
        
        
        dividerBottomView.backgroundColor = UIColor.black
        dividerBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    private func styleBottomDivider() {
        dividerBottomView.alpha = hasBottomDivider ? 1 : 0
    }
    
    private func layout() {
        addSubview(dividerTopView)
        addSubview(titleLabel)
        
        addSubview(dividerBottomView)
        
        NSLayoutConstraint.activate([
            dividerTopView.heightAnchor.constraint(equalToConstant: 0.5),
            dividerTopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerTopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerTopView.topAnchor.constraint(equalTo: topAnchor),
            
            
            dividerBottomView.heightAnchor.constraint(equalToConstant: 0.5),
            dividerBottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerBottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerBottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
        
        
        
    }
    
}


extension ButtonView {
    
    private func styleLabel(title: String) {
        titleLabel.font  = UIFont(name: "SFProText-Regular", size: 10)
        titleLabel.textColor =  UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        titleLabel.attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
}


