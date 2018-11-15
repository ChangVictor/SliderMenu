//
//  SpacerView.swift
//  SliderMenu
//
//  Created by Victor Chang on 15/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class SpacerView: UIView {
    
    var space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 16, height: 16)
        
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
