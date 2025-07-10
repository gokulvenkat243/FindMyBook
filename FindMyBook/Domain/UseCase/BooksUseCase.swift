//
//  BooksUseCase.swift
//  FindMyBook
//
//  Created by gokul v on 03/07/25.
//

import Foundation

protocol BooksUseCase {
    func fetchTrendingBooks(completion: @escaping (Result<BooksResponseData, Error>) -> Void)
    func fetchBookDetails(id: String, completion: @escaping (Result<BookDetailsPageData, any Error>) -> Void)
    func searchBooks(query: String, completion: @escaping (Result<BooksResponseData, Error>) -> Void)
}

class DefaultBookUseCase: BooksUseCase {

    private let bookRepository: BooksRepository
    private let favoriteStorage: FavoriteStorage

    init(bookRepository: BooksRepository, favoriteStorage: FavoriteStorage) {
        self.bookRepository = bookRepository
        self.favoriteStorage = favoriteStorage
    }

    func fetchTrendingBooks(completion: @escaping (Result<BooksResponseData, any Error>) -> Void) {
        self.bookRepository.fetchTrendingBooks(completion: completion)
    }

    func searchBooks(query: String, completion: @escaping (Result<BooksResponseData, Error>) -> Void) {
        self.bookRepository.searchBooks(query: query, completion: completion)
    }

    func fetchBookDetails(id: String, completion: @escaping (Result<BookDetailsPageData, any Error>) -> Void) {
        self.bookRepository.fetchBookDetails(id: id, completion: completion)
    }
}
