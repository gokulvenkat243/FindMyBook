//
//  EndPoint.swift
//  FindMyBook
//
//  Created by gokul v on 01/07/25.
//

import Foundation

struct APIEndPoints {

    static let baseUrl = "https://www.googleapis.com/books/v1"
    static let apiKey = "AIzaSyD9Znk3ZQyfUY1-cGcyjvi1bSNsb4g_lGo"

    static func getSearchResults(query: String) -> String {
        return "\(baseUrl)/volumes?q=\(query)&key=\(apiKey)"
    }

    static func getTrendingBooks() -> String {
        return "\(baseUrl)/volumes?q=trending+books+today&key=\(apiKey)"
    }

    static func getBookDetails(id: String) -> String {
        return "\(baseUrl)/volumes/\(id)?key=\(apiKey)"
    }
}
