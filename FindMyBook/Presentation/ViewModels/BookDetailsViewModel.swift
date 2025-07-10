//
//  BookDetailsViewModel.swift
//  FindMyBook
//
//  Created by gokul v on 07/07/25.
//

import Foundation

protocol BookDetailsViewModel {
    func fetchBookDetails()
    var bookDetailsData: BookDetailsPageData? { get set }
    var updateBookDetailsData: ((BookDetailsPageData) -> Void)? {get set}
    func tapToBackButton()
}

class DefaultBookDetailsViewModel: BookDetailsViewModel {

    private let useCase: BooksUseCase
    private let id: String
    var bookDetailsData: BookDetailsPageData?
    private let coordinator: BooksCoordinator
    var updateBookDetailsData: ((BookDetailsPageData) -> Void)?

    init(useCase: BooksUseCase, id: String, coordinator: BooksCoordinator) {
        self.useCase = useCase
        self.id = id
        self.coordinator = coordinator
    }

    func fetchBookDetails() {
        self.useCase.fetchBookDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.bookDetailsData = success
                    self?.updateBookDetailsData?(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }

    func tapToBackButton() {
        self.coordinator.backToHome()
    }
}
