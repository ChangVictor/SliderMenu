//
//  BaseSlidingControllerViewController.swift
//  SliderMenu
//
//  Created by Victor Chang on 13/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class BaseSlidingController: UIViewController {
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blueVIew: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        setupViews()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        print(translation.x)
        var  x = translation.x
        // limits it's width so it doesn't go over the the view width
        x = min(menuWidth, x)
        
        redViewLeadingConstraint.constant = x
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueVIew)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueVIew.topAnchor.constraint(equalTo: view.topAnchor),
            blueVIew.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueVIew.widthAnchor.constraint(equalToConstant: menuWidth),
            blueVIew.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
//        redViewLeadingConstraint.constant = 150
        redViewLeadingConstraint.isActive = true
    }


}
