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
        
        
        let rootViewController = MainViewController(nibName: nil, bundle: nil)
        let naviController = UINavigationController(rootViewController: rootViewController)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = naviController
        window?.makeKeyAndVisible()
        
        return true
    }

}

// networkmanager 정리  -- 00
// 셀 변수명 정리          -- 00
// reducer , reactor 생성 연결  -- 00
// crud 처리 연결.    -- 00
// InterActor 생성.  -- 해야하나??? 흠....


// main color 정리
// large title text.   - 00
// 
