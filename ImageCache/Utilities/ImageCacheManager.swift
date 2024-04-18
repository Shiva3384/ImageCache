//
//  ImageCacheManager.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import Foundation
import UIKit

class ImageCacheManager {
    
    static let instance = ImageCacheManager()
    let imageCache = NSCache<AnyObject, AnyObject>()
    private init() {
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 1024 * 1024 * 100
    }
    
    // Store images to Cache
    func addImageToCache(key: String, image: UIImage?) {
        guard let image = image else {
            return
        }
        imageCache.setObject(image, forKey: key as AnyObject)
    }
    
    // Get images from Cache
    func getImageFromCache(key: String) -> UIImage? {
        return imageCache.object(forKey: key as AnyObject) as? UIImage
    }
}
