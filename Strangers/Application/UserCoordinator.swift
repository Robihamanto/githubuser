//
//  UserCoordinator.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class UserCoordinator: Coordinator {
    
    var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UserDetailsViewController.instantiate()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigate(to userID: Int) {
        let vc = UserDetailsViewController.instantiate()
        vc.userID = userID
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}
