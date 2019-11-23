//
//  AppDelegate.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let splitVC = window!.rootViewController as! UISplitViewController
        let navigationController = splitVC.viewControllers[splitVC.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        splitVC.delegate = self
        return true
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        ReachabilityManager.shared.stopMonitoring()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ReachabilityManager.shared.startMonitoring()
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else {
            return false
        }
        if topAsDetailController.detailItem == nil {
            return true
        }
        return false
    }

}
