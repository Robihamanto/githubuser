//
//  HomeCoordinator.swift
//  Strangers
//
//  Created by Robihamanto on 05/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit


class HomeCoordinator {
    
    var navigationController: CoordinatedNavigationController
    
    init(navigationController: CoordinatedNavigationController = CoordinatedNavigationController()) {
        self.navigationController = navigationController
        
        let viewController = HomeViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(title: "Strangers", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        viewController.coordinator = self
        
        navigationController.viewControllers = [viewController]
    }
    
}
