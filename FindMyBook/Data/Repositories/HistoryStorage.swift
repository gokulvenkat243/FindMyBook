//
//  HistoryStorage.swift
//  FindMyBook
//
//  Created by gokul v on 14/07/25.
//

import Foundation
import CoreData
import UIKit

class HistoryStorage {

    static let shared = HistoryStorage()

    private var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }

    func addToHistory(data: BookItem) {
        guard let context = context else {
            return
        }

        let fetchRequest: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", data.id)

        //Remove if already exist items
        if let existing = try? context.fetch(fetchRequest), let first = existing.first {
            context.delete(first)
        }

        let entity = HistoryEntity(context: context)
        entity.id = data.id
        entity.title = data.volumeInfo.title
        entity.viewedDate = Date()

        do {
            try context.save()
        } catch {
            print("Error to save history: \(error)")
        }
    }

    func getAllHistory() -> [HistoryModel] {
        guard let context = context else { return [] }

        let request: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        let sort = NSSortDescriptor(key: "viewedDate", ascending: false)
        request.sortDescriptors = [sort]

        do {
            let result = try context.fetch(request)
            return result.map {
                HistoryModel(id: $0.id ?? "",
                             title: $0.title ?? "",
                             viewedDate: $0.viewedDate ?? Date())
            }
        } catch {
            print("❌ Failed to fetch recently viewed books: \(error)")
            return []
        }
    }

    func clearAllHistory() {
        guard let context = context else { return }

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = HistoryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("❌ Failed to clear history: \(error)")
        }
    }

    func removeHistory(id: String) {
        let request: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        if let result = try? context?.fetch(request).first {
            context?.delete(result)
            do {
                try context?.save()
            } catch {
                print("Error while removing Favorite")
            }
        }
    }
}
