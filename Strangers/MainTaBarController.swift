//
//  MainTaBarController.swift
//  Strangers
//
//  Created by Robihamanto on 05/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class MainTaBarController: UITabBarController {
    
    let home = HomeCoordinator()
    let setting = SettingCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [home.navigationController, setting.navigationController]
    }
    

    /// If we get some launch options, figure out which one was requested and jump right to the correct tab.
    func handle(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let item = launchOptions?[.shortcutItem] as? UIApplicationShortcutItem {
            handle(shortcutItem: item)
        }
    }

    func handle(shortcutItem: UIApplicationShortcutItem) {
//        switch shortcutItem.type {
//        case "com.hackingwithswift.unwrapswift.challenges":
//            selectedViewController = challenges.splitViewController
//        case "com.hackingwithswift.unwrapswift.news":
//            selectedViewController = news.splitViewController
//        default:
//            fatalError("Unknown shortcut item type: \(shortcutItem.type).")
//        }
    }

}
