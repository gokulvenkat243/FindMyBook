//
//  BooksCoordinator.swift
//  FindMyBook
//
//  Created by gokul v on 05/07/25.
//

import Foundation
import UIKit

class BooksCoordinator {

    private let navController: UINavigationController

    init(navController: UINavigationController) {
        self.navController = navController
    }

    func showProductDetails(id: String) {
        let dataTransfer = DefaultDataTransferService()
        let repo = DefaultBooksRepository(dataTransferService: dataTransfer)
        let favorite = FavoriteStorage()
        let useCase = DefaultBookUseCase(bookRepository: repo, favoriteStorage: favorite)
        let coordinator = BooksCoordinator(navController: navController)
        let viewModel = DefaultBookDetailsViewModel(useCase: useCase, id: id, coordinator: coordinator)
        let viewController = BookDetailsViewController(viewModel: viewModel)
        self.navController.pushViewController(viewController, animated: true)
    }

    func backToHome() {
        navController.popViewController(animated: true)
    }
}
