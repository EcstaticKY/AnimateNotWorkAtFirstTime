//
//  AppDelegate.swift
//  MeBoxApp
//
//  Created by Kanyan Zheng on 2022/4/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootVC = UINavigationController(rootViewController: RouterViewController())
//        let rootVC = FamilyFeedUIComposer.composedForTest()
//        let rootVC = CustomNavigationController()
//        rootVC.root
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

