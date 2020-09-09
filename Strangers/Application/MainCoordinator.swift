//
//  MainCoordinator.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        // vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToUserDetail(to userID: Int) {
        let child = UserCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.navigate(to: userID)
    }
    
    func navigateToSetting() {
//        let child = SettingCoordinator()
//        child.parentCoordinator = self
//        childCoordinators.append(child)
//        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // check back button did tap from user details
//        if let userDetailCoordinator = fromViewController as? UserDetailsViewController {
//            childDidFinish(userDetailCoordinator.coordinator)
//            return
//        }
        
        // check back button did tap from setting
//        if let userDetailCoordinator = fromViewController as? SettingViewController {
//            childDidFinish(userDetailCoordinator.coordinator)
//            return
//        }
    }

}
