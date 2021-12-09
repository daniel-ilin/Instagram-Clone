//
//  AppDelegate.swift
//  Insagram Clone
//
//  Created by Daniel Ilin on 01.12.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = createNavigationController()
        
        return true
    }
    
    func createNavigationController() -> UINavigationController {
        let controller = UINavigationController(rootViewController: MainTabController())        
        return controller
    }

}

