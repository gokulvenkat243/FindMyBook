//
//  BookDetailsModel.swift
//  FindMyBook
//
//  Created by gokul v on 07/07/25.
//

import Foundation

struct BookDetailsPageData: Decodable {
    let id: String
    let title: String
    let subtitle: String?
    let authors: [String]?
    let description: String?
    let thumbnail: String?
    let pageCount: Int?
    let publisher: String?
    let publishedDate: String?
    let previewLink: String?
    let infoLink: String?
    let webReaderLink: String?
}
