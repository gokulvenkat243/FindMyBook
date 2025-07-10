//
//  BooksRepository.swift
//  FindMyBook
//
//  Created by gokul v on 03/07/25.
//

import Foundation

protocol BooksRepository {
    func fetchTrendingBooks(completion: @escaping(Result<BooksResponseData, Error>) -> Void)
    func fetchBookDetails(id: String, completion: @escaping (Result<BookDetailsPageData, any Error>) -> Void)
    func searchBooks(query: String, completion: @escaping (Result<BooksResponseData, Error>) -> Void)
}

class DefaultBooksRepository: BooksRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }

    func fetchTrendingBooks(completion: @escaping (Result<BooksResponseData, any Error>) -> Void) {
        let urlPath = APIEndPoints.getTrendingBooks()
        print(urlPath)

        dataTransferService.request(urlPath: urlPath) { (result: Result<ApiBooksModel, Error>)  in
            switch result {
            case .success(let success):
                let data = success.toDomain()
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func searchBooks(query: String, completion: @escaping (Result<BooksResponseData, Error>) -> Void) {
        let urlPath = APIEndPoints.getSearchResults(query: query)

        dataTransferService.request(urlPath: urlPath) { (result: Result<ApiBooksModel, Error>)  in
            switch result {
            case .success(let success):
                let data = success.toDomain()
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func fetchBookDetails(id: String, completion: @escaping (Result<BookDetailsPageData, any Error>) -> Void) {
        let urlPath = APIEndPoints.getBookDetails(id: id)

        dataTransferService.request(urlPath: urlPath) { (result: Result<ApiBookItem, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success.toBookDetails()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

extension ApiImageLinks {
    func toDomain() -> ImageLinks {
        return ImageLinks(smallThumbnail: smallThumbnail, thumbnail: thumbnail, small: small, medium: medium, large: large, extraLarge: extraLarge)
    }
}

extension ApiAccessInfo {
    func toDomain() -> AccessInfo {
        return AccessInfo(webReaderLink: webReaderLink)
    }
}

extension ApiVolumeInfo {
    func toDomain() -> VolumeInfo {
        return VolumeInfo(title: title, subtitle: subtitle, authors: authors, publisher: publisher, publishedDate: publishedDate, description: description, pageCount: pageCount, imageLinks: imageLinks?.toDomain(), previewLink: previewLink, infoLink: infoLink, canonicalVolumeLink: canonicalVolumeLink)
    }
}

extension ApiBookItem {
    func toDomain() -> BookItem {
        return BookItem(id: id, volumeInfo: volumeInfo.toDomain(), accessInfo: accessInfo.toDomain())
    }

    func toBookDetails() -> BookDetailsPageData {
        return BookDetailsPageData(id: id, title: volumeInfo.title, subtitle: volumeInfo.subtitle, authors: volumeInfo.authors, description: volumeInfo.description, thumbnail: volumeInfo.imageLinks?.thumbnail, pageCount: volumeInfo.pageCount, publisher: volumeInfo.publisher, publishedDate: volumeInfo.publishedDate, previewLink: volumeInfo.previewLink, infoLink: volumeInfo.infoLink, webReaderLink: accessInfo.webReaderLink)
    }
}

extension ApiBooksModel {
    func toDomain() -> BooksResponseData {
        return BooksResponseData(items: items?.map{ $0.toDomain() })
    }
}
