//
//  BooksModel.swift
//  FindMyBook
//
//  Created by gokul v on 03/07/25.
//

import Foundation

import Foundation

struct BooksResponseData: Decodable {
    let items: [BookItem]?
}

struct BookItem: Decodable {
    let id: String
    let volumeInfo: VolumeInfo
    let accessInfo: AccessInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let imageLinks: ImageLinks?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

struct ImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
    let extraLarge: String?
}

struct AccessInfo: Decodable {
    let webReaderLink: String?
}


struct ApiBooksModel: Decodable {
    let items: [ApiBookItem]?
}

struct ApiBookItem: Decodable {
    let id: String
    let volumeInfo: ApiVolumeInfo
    let accessInfo: ApiAccessInfo
}

struct ApiVolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let imageLinks: ApiImageLinks?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

struct ApiImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
    let extraLarge: String?
}

struct ApiAccessInfo: Decodable {
    let webReaderLink: String?
}
