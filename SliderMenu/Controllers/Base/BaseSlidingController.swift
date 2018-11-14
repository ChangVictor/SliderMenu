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

        var  x = translation.x
        // limits it's width so it doesn't go over the the view width
        x = min(menuWidth, x)
        x = max(0, x)
        
        x = isMenuOpened ? x + menuWidth : x
        
        redViewLeadingConstraint.constant = x
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if translation.x < menuWidth / 2 {
            redViewLeadingConstraint.constant = 0
            isMenuOpened = false
        } else {
            redViewLeadingConstraint.constant = menuWidth
            isMenuOpened = true
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueVIew)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueVIew.topAnchor.constraint(equalTo: view.topAnchor),
            blueVIew.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueVIew.widthAnchor.constraint(equalToConstant: menuWidth),
            blueVIew.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let homeController = HomeController()
        let menuController = MenuController()
        
        guard let menuView = menuController.view else { return }
        guard let homeView = homeController.view else { return }
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        blueVIew.addSubview(menuView)
        
        NSLayoutConstraint.activate([
                homeView.topAnchor.constraint(equalTo: redView.topAnchor),
                homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
                
                menuView.topAnchor.constraint(equalTo: blueVIew.topAnchor),
                menuView.leadingAnchor.constraint(equalTo: blueVIew.leadingAnchor),
                menuView.bottomAnchor.constraint(equalTo: blueVIew.bottomAnchor),
                menuView.trailingAnchor.constraint(equalTo: blueVIew.trailingAnchor)
            ])
        
        addChild(homeController)
        addChild(menuController)
    }


}
