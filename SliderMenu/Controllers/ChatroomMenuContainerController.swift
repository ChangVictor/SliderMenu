//
//  ChatroomMenuContainerController.swift
//  SliderMenu
//
//  Created by Victor Chang on 20/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class ChatroomMenuContainerController: UIViewController {
    
    let chatroomMenuController = ChatroomsMenuController()
    let searchContrainer = SearchContainerView()
    let rocketImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        
        let chatroomsView = chatroomMenuController.view!
        view.addSubview(chatroomsView)
        
        view.addSubview(searchContrainer)
        searchContrainer.backgroundColor = #colorLiteral(red: 0.2469533682, green: 0.1305064261, blue: 0.2499337196, alpha: 1)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        
        
        searchContrainer.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 120))
        searchContrainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        chatroomsView.anchor(top: searchContrainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}

class SearchContainerView: UIView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Enter search parameters... "
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    addSubview(searchBar)
    searchBar.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding:.init(top: 0, left: 0, bottom: 4, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
