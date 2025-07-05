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
        let dataTransfer = DefaultDataTransferService()
        let repository = DefaultBooksRepository(dataTransferService: dataTransfer)
        let useCase = DefaultBookUseCase(bookRepository: repository)
        let viewModel = DefaultBooksHomeViewModel(useCase: useCase)
        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        let profileVC = UIViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Favorite",
                                            image: UIImage(systemName: "star"),
                                            selectedImage: UIImage(systemName: "star.fill"))

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: homeVC),

            UINavigationController(rootViewController: profileVC)
        ]

        tabBarController.tabBar.tintColor = UIColor.gray
        tabBarController.tabBar.unselectedItemTintColor = UIColor.gray
        tabBarController.tabBar.layer.borderWidth = 0.2
        tabBarController.tabBar.backgroundColor = .white
        navController.setViewControllers([tabBarController], animated: false)
    }
}
