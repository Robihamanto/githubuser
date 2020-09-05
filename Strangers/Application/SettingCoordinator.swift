//
//  SettingCoordinator.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class SettingCoordinator {
    
    var navigationController: CoordinatedNavigationController
    
    init(navigationController: CoordinatedNavigationController = CoordinatedNavigationController()) {
        self.navigationController = navigationController
        
        let viewController = SettingViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        viewController.coordinator = self
        
        navigationController.viewControllers = [viewController]
    }
}
