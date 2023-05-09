//
//  AppDelegate.swift
//  IOS-Calculator
//
//  Created by Laureano Velasco on 07/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // setup
        setuupView()
        return true
    }

    //MARK: - Private methods
    
    private func setuupView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        
    }


}

