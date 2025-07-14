//
//  HistoryViewModel.swift
//  FindMyBook
//
//  Created by gokul v on 11/07/25.
//

import Foundation

protocol HistoryViewModel {
    var onDataChanged: (() -> Void)? { get set }
    func numberOfItems() -> Int
    func getItem(at index: Int) -> HistoryModel
    func fetchHistory()
    func clearAllHistory()
    func removeParticularHistory(at index: Int) -> Bool
}

class DefaultHistoryViewModel: HistoryViewModel {
    private var item: [HistoryModel] = []
    var onDataChanged: (() -> Void)?

    func numberOfItems() -> Int {
        return item.count
    }

    func getItem(at index: Int) -> HistoryModel {
        return item[index]
    }

    func fetchHistory() {
        self.item = HistoryStorage.shared.getAllHistory()
        self.onDataChanged?()
    }

    func clearAllHistory() {
        HistoryStorage.shared.clearAllHistory()
        self.fetchHistory()
    }

    func removeParticularHistory(at index: Int) -> Bool {
        if index < item.count {
            let book = item[index]
            HistoryStorage.shared.removeHistory(id: book.id)
            item.remove(at: index)
            return true
        }
        return false
    }
}
