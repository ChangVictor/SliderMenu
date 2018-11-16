//
//  MenuController.swift
//  SliderMenu
//
//  Created by Victor Chang on 10/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

class MenuController: UITableViewController {
    
    let menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "profile"), title: "Profile"),
        MenuItem(icon: #imageLiteral(resourceName: "lists"), title: "List"),
        MenuItem(icon: #imageLiteral(resourceName: "bookmark"), title: "Bookmark"),
        MenuItem(icon: #imageLiteral(resourceName: "moments"), title: "Moments")
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellId")
        let menuItem = self.menuItems[indexPath.row ]
        cell.iconImageView.image = menuItem.icon
        cell.titleLabel.text = menuItem.title
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
