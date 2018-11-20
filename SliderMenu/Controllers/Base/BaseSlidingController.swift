//
//  BaseSlidingControllerViewController.swift
//  SliderMenu
//
//  Created by Victor Chang on 13/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingController: UIViewController {
    
    let redView: RightContainerView = {
        let view = RightContainerView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blueVIew: MenuContainerView = {
        let view = MenuContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkCoverView: DarkCoverView = {
        let view = DarkCoverView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupNavigationItems()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleTapDismiss() {
        handleHide()
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // limits it's width so it doesn't go over the the view width
        var  x = translation.x
        x = min(menuWidth, x)
        x = max(0, x)
        
        x = isMenuOpened ? x + menuWidth : x
        
        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpened ? .lightContent : .default
    }
    
    @objc func handleOpen() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        performAnimation()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc func handleHide() {
        isMenuOpened = false
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        self.performAnimation()
        setNeedsStatusBarAppearanceUpdate()

    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        
        performRightViewCleanup()
        handleHide()
        
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeController())
            
        case 1:
            rightViewController = UINavigationController(rootViewController: ListsController() )
            
        case 2:
            rightViewController = BookmarksController()
        default:
            let tabBarController = UITabBarController()
            let momentsController = UIViewController()
            momentsController.navigationItem.title = "Moments"
            momentsController.view.backgroundColor = .orange
            let navController = UINavigationController(rootViewController: momentsController)
            navController.tabBarItem.title = "Moments"
            tabBarController.viewControllers = [navController]
            rightViewController = tabBarController
        }
        
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        redView.bringSubviewToFront(darkCoverView)
    }

    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    let menuController = ChatroomMenuContainerController()

    fileprivate func performRightViewCleanup() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }

    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityOpenThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueVIew)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blueVIew.topAnchor.constraint(equalTo: view.topAnchor),
            blueVIew.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueVIew.widthAnchor.constraint(equalToConstant: menuWidth),
            blueVIew.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true

        
        setupViewControllers()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "BaseSliderMenu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .done, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(handleHide))
    }
    
    fileprivate func setupViewControllers() {
        guard let menuView = menuController.view else { return }
        guard let homeView = rightViewController.view else { return }
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
        
        addChild(rightViewController)
        addChild(menuController)
    }

}
