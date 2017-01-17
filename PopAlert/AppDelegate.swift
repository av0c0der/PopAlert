//
//  AppDelegate.swift
//  PopAlert
//
//  Created by Abdurahim Jauzee on 17/01/2017.
//  Copyright © 2017 Abdurahim Jauzee. All rights reserved.
//

import UIKit

let kAlertOptionSaveTempKey = "kAlertOptionSaveTempKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }
    
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        window!.rootViewController = ViewController(nibName: nil, bundle: nil)
    }

}
