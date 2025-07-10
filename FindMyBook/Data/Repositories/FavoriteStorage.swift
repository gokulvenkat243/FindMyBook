//
//  FavoriteStorage.swift
//  FindMyBook
//
//  Created by gokul v on 09/07/25.
//

import Foundation
import CoreData
import UIKit

class FavoriteStorage {

    static let shared = FavoriteStorage()

    private var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }

    func addFavorite(data: BookDetailsPageData) {
        guard let context = context else {
            return
        }
        guard !isFavorite(id: data.id) else { return }

        let entity = FavoriteBookEntity(context: context)
        entity.id = data.id
        entity.title = data.title
        entity.author = data.authors?.joined(separator: ", ")
        entity.thumbnailURL = data.thumbnail

        do {
            try context.save()
        } catch {
            print("Error in add Favorites")
        }
    }

    func removeFavorite(id: String) {
        let request: NSFetchRequest<FavoriteBookEntity> = FavoriteBookEntity.fetchRequest()
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

    func isFavorite(id: String) -> Bool {
        guard let context = context else { return false }

        let request: NSFetchRequest<FavoriteBookEntity> = FavoriteBookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1

        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch {
            print("❌ Error checking favorite: \(error)")
            return false
        }
    }

    func getAllFavorites() -> [FavoriteBooksModel] {
        guard let context = context else { return [] }

        let request: NSFetchRequest<FavoriteBookEntity> = FavoriteBookEntity.fetchRequest()

        do {
            let entities = try context.fetch(request)
            return entities.map {
                FavoriteBooksModel(
                    id: $0.id ?? "",
                    title: $0.title ?? "",
                    author: $0.author ?? "",
                    thumbnailURL: $0.thumbnailURL ?? ""
                )
            }
        } catch {
            print("❌ Error fetching favorites: \(error)")
            return []
        }
    }
}
