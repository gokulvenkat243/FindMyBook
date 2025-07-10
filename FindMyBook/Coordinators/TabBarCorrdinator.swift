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
        let favorite = FavoriteStorage()
        let useCase = DefaultBookUseCase(bookRepository: repository, favoriteStorage: favorite)
        let coordinator = BooksCoordinator(navController: navController)
        let viewModel = DefaultBooksHomeViewModel(useCase: useCase, coordinator: coordinator)
        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        let favViewModel = DefaultFavoriteBooksViewModel(usecase: useCase, coordinator: coordinator)
        let profileVC = FavoriteBooksViewController(viewModel: favViewModel)
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
