//
//  BooksUseCase.swift
//  FindMyBook
//
//  Created by gokul v on 03/07/25.
//

import Foundation

protocol BooksUseCase {
    func fetchTrendingBooks(completion: @escaping (Result<BooksResponseData, Error>) -> Void)
}

class DefaultBookUseCase: BooksUseCase {

    private let bookRepository: BooksRepository

    init(bookRepository: BooksRepository) {
        self.bookRepository = bookRepository
    }

    func fetchTrendingBooks(completion: @escaping (Result<BooksResponseData, any Error>) -> Void) {
        self.bookRepository.fetchTrendingBooks(completion: completion)
    }
}
