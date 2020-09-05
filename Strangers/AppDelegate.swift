//
//  AppDelegate.swift
//  Strangers
//
//  Created by Robihamanto on 20/07/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController: MainTaBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        tabBarController = MainTaBarController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        tabBarController?.handle(launchOptions)
               
        return true
    }

}

