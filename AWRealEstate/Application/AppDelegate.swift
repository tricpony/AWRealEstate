//
//  AppDelegate.swift
//  AWRealEstate
//
//  Created by aarthur on 4/26/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let root = SplitViewController(style: .doubleColumn)
        
        // iPad setup
        configRegularNavStack(in: root)

        // iPhone setup
        configCompactNavStack(in: root)

        window.rootViewController = root
        window.makeKeyAndVisible()

        return true
    }

    private func configCompactNavStack(in split: UISplitViewController) {
        let master = MasterViewController(isCompact: true)
        let nav = UINavigationController(rootViewController: master)
        split.setViewController(nav, for: .compact)
    }

    private func configRegularNavStack(in split: UISplitViewController) {
        let master = MasterViewController(isCompact: false)
        let detail = PlaceholderViewController()
        let nav = UINavigationController(rootViewController: detail)
        split.setViewController(master, for: .primary)
        split.setViewController(nav, for: .secondary)
    }
}

