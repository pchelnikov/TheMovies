//
//  AppDelegate.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 08/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().tintColor = .black
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)
        UITabBar.appearance().tintColor = .black

        //Initital Window and root View Controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        window?.rootViewController = TabBarViewController()
        
        return true
    }
}
