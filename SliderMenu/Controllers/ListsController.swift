//
//  ListsController.swift
//  SliderMenu
//
//  Created by Victor Chang on 17/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class ListsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "Lists"
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)
        
    }
}
