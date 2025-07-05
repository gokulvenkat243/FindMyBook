//
//  BooksRepository.swift
//  FindMyBook
//
//  Created by gokul v on 03/07/25.
//

import Foundation

protocol BooksRepository {
    func fetchTrendingBooks(completion: @escaping(Result<BooksResponseData, Error>) -> Void)
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
}

extension ApiBooksModel {
    func toDomain() -> BooksResponseData {
        return BooksResponseData(items: items?.map{ $0.toDomain() })
    }
}
