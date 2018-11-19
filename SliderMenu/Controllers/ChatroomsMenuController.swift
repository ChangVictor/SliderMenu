//
//  ChatroomsMenuController.swift
//  SliderMenu
//
//  Created by Victor Chang on 19/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class ChatroomsMenuController: UITableViewController {
    
    let chatroomGroups = [
    
        ["general", "introductions"],
        ["jobs"],
        ["Victor Chang", "Steve Jobs", "Tim Cook", "Barack Obama"]
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2196078431, blue: 0.2862745098, alpha: 1)
        tableView.separatorStyle = .none
    
    }
    
}

extension ChatroomsMenuController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "UNREADS" : section == 1 ? "CHANNELS": "DIRECT MESSAGES"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatroomGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatroomGroups[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let text = chatroomGroups[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        return cell
    }
    
}
