//
//  PokeAppDelegate.swift
//  FistPunchPokeBam
//
//  Created by K Y on 6/10/19.
//  Copyright © 2019 KY. All rights reserved.
//

import UIKit

@UIApplicationMain
class PokeAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let service = CoreDataService.shared
        service.removeAllWildPokemon()
        
        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        
        // new entry-way into the app,
        // previous path is basically shoved ito 'GameStartViewController'
        let rootVC = GameStartViewController()
        let vc = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }

}

