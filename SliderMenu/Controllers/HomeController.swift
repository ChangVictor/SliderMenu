//
//  ViewController.swift
//  SliderMenu
//
//  Created by Victor Chang on 10/11/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class HomeController: UITableViewController, UIGestureRecognizerDelegate{
    
    let menuController = MenuController()
    fileprivate var isMenuOpen = false
    fileprivate let velocityOpenThreshold: CGFloat = 500
    let darkCoverView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .lightGray
        setupNavigationItems()
        setupMenuController()
        setupPanGesture()
        
        setupDarkCoverView()

    }
    
    fileprivate func setupDarkCoverView() {
        
        darkCoverView.alpha = 0
        let mainWindow = UIApplication.shared.keyWindow
        darkCoverView.frame = mainWindow?.frame ?? .zero
        mainWindow?.addSubview(darkCoverView)
        darkCoverView.backgroundColor = UIColor(white: 0 , alpha: 0.8)
        darkCoverView.isUserInteractionEnabled = false
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        
        if gesture.state == .changed {
            
            var x = translation.x
            
            if isMenuOpen {
                x += self.view.frame.width * 2/3
            }

            x = min(self.view.frame.width * 2/3, x)
            x = max(0, x)
            
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuController.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            
            let alpha = x / (self.view.frame.width * 2/3)
            darkCoverView.alpha = alpha
        } else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let menuWidth = self.view.frame.width * 2/3
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpen {
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
            if velocity.x > velocityOpenThreshold {
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
    
    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        menuController.view.frame = CGRect(x: 0, y: 0, width: 200, height: 500)
//    }
    
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -(self.view.frame.width * 2/3), y: 0, width: self.view.frame.width * 2/3, height: self.view.frame.height)
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    fileprivate let menuWidth: CGFloat = 300
    
    fileprivate func performAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = transform
//            self.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCoverView.transform = transform
            
            self.darkCoverView.alpha = transform == .identity ? 0 : 1
            
//            if transform == .identity {
//                self.darkCoverView.alpha = 0
//            } else {
//                self.darkCoverView.alpha = 1
//            }
            
        }, completion: nil)
    }
    
    @objc fileprivate func handleOpen() {
        
        isMenuOpen = true
        performAnimations(transform: CGAffineTransform(translationX: self.view.frame.width * 2/3, y: 0))

    }
    
    @objc fileprivate func handleHide() {
        
        isMenuOpen = false
        performAnimations(transform: .identity)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        
        cell.textLabel?.text = "Row: \(indexPath.row)"
        
        return cell
        
    }
    
}

