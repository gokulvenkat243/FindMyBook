//
//  FavoriteBooksViewModel.swift
//  FindMyBook
//
//  Created by gokul v on 09/07/25.
//

import Foundation

protocol FavoriteBooksViewModel {
    var onDataChanged: (() -> Void)? { get set }
    func numberOfItems() -> Int
    func getBook(at index: Int) -> FavoriteBooksModel
    func fetchFavoriteBooks()
    func removeFavorite(at index: Int) -> Bool
    func showBookDetails(id: String)
}

class DefaultFavoriteBooksViewModel: FavoriteBooksViewModel {

    private var favoriteItem: [FavoriteBooksModel] = []
    var onDataChanged: (() -> Void)?
    private let usecase: BooksUseCase
    private let coordinator: BooksCoordinator

    init(usecase: BooksUseCase, coordinator: BooksCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }

    func fetchFavoriteBooks() {
        self.favoriteItem = FavoriteStorage.shared.getAllFavorites()
        onDataChanged?()
    }

    func numberOfItems() -> Int {
        return favoriteItem.count
    }

    func getBook(at index: Int) -> FavoriteBooksModel {
        return favoriteItem[index]
    }

    func removeFavorite(at index: Int) -> Bool {
        if index < favoriteItem.count {
            let book = favoriteItem[index]
            FavoriteStorage.shared.removeFavorite(id: book.id)
            favoriteItem.remove(at: index)
            return true
        }
        return false
    }

    func showBookDetails(id: String) {
        self.coordinator.showProductDetails(id: id)
    }
}
