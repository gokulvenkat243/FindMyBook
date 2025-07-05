//
//  Extensions.swift
//  FindMyBook
//
//  Created by gokul v on 30/06/25.
//

import Foundation
import UIKit

extension UIView {

    @inline(__always) static func construct<T>(applyAttributes: ((T) -> Void)? = nil) -> T where T: UIView {
        let uiComponent = T(frame: .zero)
        uiComponent.translatesAutoresizingMaskIntoConstraints = false
        applyAttributes?(uiComponent)
        return uiComponent
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

public extension UICollectionViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UITableViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(imageUrl: String?, placeholderAssetName: String = "EmptyBookImage") {
        self.image = UIImage(named: placeholderAssetName)

        guard let imageUrl = imageUrl,
              !imageUrl.isEmpty,
              let encodedUrl = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            print("🚫 Invalid URL: \(imageUrl ?? "nil")")
            return
        }

        if let cachedImage = imageCache.object(forKey: imageUrl as NSString) {
            print("📦 Loaded from cache: \(imageUrl)")
            self.image = cachedImage
            return
        }

        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                if let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: imageUrl as NSString)
                    DispatchQueue.main.async {
                        print("✅ Loaded image from URL: \(url)")
                        self.image = downloadedImage
                    }
                } else {
                    print("❌ Could not decode image data")
                }
            } catch {
                print("❌ Error loading image: \(error.localizedDescription)")
            }
        }
    }
}
