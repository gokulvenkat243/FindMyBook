//
//  TabBarCorrdinator.swift
//  FindMyBook
//
//  Created by gokul v on 17/05/25.
//

import Foundation
import UIKit

final class TabBarCoordinator {

    private let navController: UINavigationController
    private let tabBarController: UITabBarController

    init(navController: UINavigationController) {
        self.navController = navController
        self.tabBarController = UITabBarController()
    }

    func start() {

        let homeVC = ViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Search",
                                         image: UIImage(systemName: "magnifyingglass"), tag: 0)

        let profileVC = UIViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Favorite",
                                            image: UIImage(systemName: "star"), tag: 1)

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: homeVC),

            UINavigationController(rootViewController: profileVC)
        ]

        tabBarController.tabBar.tintColor = UIColor.blue
        tabBarController.tabBar.unselectedItemTintColor = UIColor.gray

        navController.setViewControllers([tabBarController], animated: false)
    }
}
