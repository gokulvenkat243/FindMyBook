//
//  BooksHomeViewModel.swift
//  FindMyBook
//
//  Created by gokul v on 01/07/25.
//

import Foundation

protocol BooksHomeViewModel {
    func fetchTrendingBooks()
    func numberOfItems() -> Int
    func getBooksData(index: Int) -> BookItem
    var updateBooksData: (() -> Void)? {get set}
    func showBookDetails(id: String)
}

class DefaultBooksHomeViewModel: BooksHomeViewModel {
    var updateBooksData: (() -> Void)?
    private var trendingBooksData: [BookItem] = []
    private let useCase: BooksUseCase
    private let coordinator: BooksCoordinator

    init(useCase: BooksUseCase, coordinator: BooksCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    func fetchTrendingBooks() {
        self.useCase.fetchTrendingBooks { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.trendingBooksData = data.items ?? []
                    self.updateBooksData?()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }

    func getBooksData(index: Int) -> BookItem {
        return trendingBooksData[index]
    }

    func numberOfItems() -> Int {
        return trendingBooksData.count
    }

    func showBookDetails(id: String) {
        self.coordinator.showProductDetails(id: id)
    }
}
