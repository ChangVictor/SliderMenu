//
//  CustomMenuHeader.swift
//  SliderMenu
//
//  Created by Victor Chang on 15/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        // custom components
        
        let nameLabel = UILabel()
        nameLabel.text = "Victor Chang"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        let userNameLabel = UILabel()
        userNameLabel.text = "@vectorChange"
        
        let statsLabel = UILabel()
        statsLabel.text = "42 following 242 followers"
        
        let arrangeSubviews = [
           UIView(), nameLabel, userNameLabel, SpacerView(space: 16), statsLabel ]
        
        let stackView = UIStackView(arrangedSubviews: arrangeSubviews)
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
