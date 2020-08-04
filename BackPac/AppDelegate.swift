//
//  AppDelegate.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // bot test commit
        let rootViewController = MainViewController(nibName: nil, bundle: nil)
        let naviController = UINavigationController(rootViewController: rootViewController)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = naviController
        window?.makeKeyAndVisible()
        
        return true
    }

}
