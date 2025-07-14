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
    func showBookDetails(id: String, data: BookItem)
    func searchBooks(query: String)
    func setSearching(_ searching: Bool)
}

class DefaultBooksHomeViewModel: BooksHomeViewModel {
    var updateBooksData: (() -> Void)?
    private var trendingBooksData: [BookItem] = []
    private let useCase: BooksUseCase
    private let coordinator: BooksCoordinator
    private var searchResults: [BookItem] = []
    private var isSearching: Bool = false

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

    func searchBooks(query: String) {
        self.useCase.searchBooks(query: query) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.searchResults = success.items ?? []
                    self.updateBooksData?()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }

    func setSearching(_ searching: Bool) {
        self.isSearching = searching
        if !searching {
            self.searchResults = []
            updateBooksData?()
        }
    }


    func getBooksData(index: Int) -> BookItem {
        return isSearching ? searchResults[index] : trendingBooksData[index]
    }

    func numberOfItems() -> Int {
        return isSearching ? searchResults.count : trendingBooksData.count
    }

    func showBookDetails(id: String, data: BookItem) {
        self.coordinator.showProductDetails(id: id)
        HistoryStorage.shared.addToHistory(data: data)
    }
}
