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
    
    let darkCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        setupViews()
//        setupNavigationItems()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // limits it's width so it doesn't go over the the view width
        var  x = translation.x
        x = min(menuWidth, x)
        x = max(0, x)
        
        x = isMenuOpened ? x + menuWidth : x
        
        redViewLeadingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityOpenThreshold {
                handleHide()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                handleOpen()
            } else {
                handleHide()
            }
        } else {
            if abs(velocity.x) > velocityOpenThreshold {
                handleOpen()
                return
            }
            
            if translation.x < menuWidth / 2 {
                handleHide()
            } else {
                handleOpen()
            }
        }
    }
    
    fileprivate func performAnimation() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        }, completion: nil)
        
    }
    
    @objc fileprivate func handleOpen() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        performAnimation()
    }
    
    @objc fileprivate func handleHide() {
        isMenuOpened = false
        redViewLeadingConstraint.constant = 0
        self.performAnimation()
    }


    var redViewLeadingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityOpenThreshold: CGFloat = 500
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
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "BaseSliderMenu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .done, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(handleHide))
    }
    
    fileprivate func setupViewControllers() {
        let homeController = HomeController()
        let menuController = MenuController()
        
        guard let menuView = menuController.view else { return }
        guard let homeView = homeController.view else { return }
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueVIew.addSubview(menuView)
        
        NSLayoutConstraint.activate([
                homeView.topAnchor.constraint(equalTo: redView.topAnchor),
                homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
                
                menuView.topAnchor.constraint(equalTo: blueVIew.topAnchor),
                menuView.leadingAnchor.constraint(equalTo: blueVIew.leadingAnchor),
                menuView.bottomAnchor.constraint(equalTo: blueVIew.bottomAnchor),
                menuView.trailingAnchor.constraint(equalTo: blueVIew.trailingAnchor),
                
                darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
                darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor)
            ])
        
        addChild(homeController)
        addChild(menuController)
    }


}
