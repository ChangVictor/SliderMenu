//
//  ChatroomMenuCell.swift
//  SliderMenu
//
//  Created by Victor Chang on 19/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class ChatroomMenuCell: UITableViewCell {
    
    let backgrounView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.6, blue: 0.5411764706, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

        addSubview(backgrounView)
        
        backgrounView.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        sendSubviewToBack(backgrounView)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgrounView.isHidden = !selected
//        backgroundColor = selected ? .orange : .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
