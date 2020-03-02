//
//  ContainerController.swift
//  Email App
//
//  Created by Kamal Maged on 2020-03-02.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import UIKit

class ContainerController: UIViewController, EmailViewControllerDelegate {
    

    var menuViewController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmailViewController()
        // Do any additional setup after loading the view.
    }
    
    func configureEmailViewController() {
            
            let emailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
            centerController = UINavigationController(rootViewController: emailViewController)
            
            view.addSubview(centerController.view)
            addChild(centerController)
            centerController.didMove(toParent: self)
            emailViewController.delegate = self
        
    }
    
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            menuViewController.delegate = self
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
                if !isExpanded {
            configureMenuViewController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldAppear: isExpanded, menuOption: menuOption)
    }
    
    func showMenuController(shouldAppear: Bool, menuOption: MenuOption?) {
        if shouldAppear {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                let width = self.centerController.view.frame.size.width
                self.centerController.view.frame.origin.x = width - width/2
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                if let menuOption = menuOption {
                    self.didSelectMenuOption(menuOption: menuOption)
                }
            }, completion: nil)
        }
        
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .inbox:
            showMenuController(shouldAppear: false, menuOption: nil)
        case .sent:
            let sentViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SentViewController") as? SentViewController)!
            present(sentViewController, animated: true)
        case .archive:
            let archiveViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArchiveViewController") as? ArchiveViewController)!
            present(archiveViewController, animated: true)

        }
    }
    
}
