//
//  MenuController.swift
//  SliderMenu
//
//  Created by Victor Chang on 10/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = .blue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Menu Item for row: \(indexPath.row)"
        return cell
        
    }
}

extension MenuController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderView = CustomMenuHeaderView()
        return customHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
