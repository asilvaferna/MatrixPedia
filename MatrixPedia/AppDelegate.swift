//
//  AppDelegate.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let rootController = CharacterListViewController()
        let navigationController = UINavigationController(rootViewController: rootController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

