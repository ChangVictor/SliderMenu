//
//  BookmarksController.swift
//  SliderMenu
//
//  Created by Victor Chang on 18/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class BookmarksController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Bookmark: \(indexPath.row)"
        return cell
    }
    
}
