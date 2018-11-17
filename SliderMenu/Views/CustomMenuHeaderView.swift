//
//  CustomMenuHeader.swift
//  SliderMenu
//
//  Created by Victor Chang on 15/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {

    let nameLabel = UILabel()
    let statsLabel = UILabel()
    let userNameLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupComponenProperties()
        setupStackView()
    }
    
    fileprivate func setupComponenProperties() {
        nameLabel.text = "Victor Chang"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        userNameLabel.text = "@vectorChange"
        statsLabel.text = "42 following 242 followers"
        profileImageView.image = UIImage(named: "victor_memoji")
        profileImageView.contentMode = .scaleAspectFit
        
        setupAttributedText()
        
    }
    
    fileprivate func setupAttributedText() {
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091  ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        let rightSpacerView = UIView()
        let arrangeSubviews = [
//            UIView(),
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            userNameLabel,
            SpacerView(space: 16),
            statsLabel
        ]
        
        let stackView = UIStackView(arrangedSubviews: arrangeSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
