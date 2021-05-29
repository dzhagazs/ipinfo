//
//  AppDelegate.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var flowManager: FlowManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flowManager = FlowManager(with: window!, mainRouter: MainRouter(modelFactory: MainViewModelFactory(), viewFactory: MainViewFactory()))
        flowManager.setupMainFlow()
        return true
    }
}

