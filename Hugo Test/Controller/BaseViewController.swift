//
//  BaseViewController.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/23/20.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(image: UIImage(named: "menu"), target: self, action: #selector(openMenu))
        
        setupSideMenu()
        
    }
    
    func setupSideMenu() {
        let menuController = MenuViewController.instantiate()
        let menuLeftNavigationController = SideMenuNavigationController(rootViewController: menuController)
        menuLeftNavigationController.navigationBar.isHidden = true
        menuLeftNavigationController.leftSide = true
        menuLeftNavigationController.menuWidth = UIScreen.main.bounds.width - 50
        menuLeftNavigationController.presentationStyle = .viewSlideOutMenuIn
        menuLeftNavigationController.statusBarEndAlpha = 0
        
        if let navigationController = self.navigationController {
            SideMenuManager.default.addPanGestureToPresent(toView: navigationController.navigationBar)
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navigationController.view)
        }
        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
        
    }
    
    @objc func openMenu() {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
}
