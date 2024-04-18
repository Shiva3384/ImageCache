//
//  ImageLoader.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage = UIImage()
    let cacheManager = ImageCacheManager.instance
    let localStorage = LocalStorageManager.instance
    var errorImage = UIImage(named: "NoImage")!
    
    
    func loadImage(for urlString: String, key: String) {
        // Get images from cache if available
        if let image = cacheManager.getImageFromCache(key: key) {
            print("Image from Cache")
            self.image = image
        }
        // Get images from disk if available and store to memory
        else if let image = localStorage.getImage(filename: key) {
            print("Image from Local")
            self.image = image
            cacheManager.addImageToCache(key: key, image: image)
        }
        // Download images from server
        else {
            downloadImage(urlString: urlString, key: key)
        }
    }
    
    func downloadImage(urlString: String, key: String) {
        print("Image Downloading")
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data, let self = self, let image = UIImage(data: data)  else {
                self?.setImageData(image:self!.errorImage , key: key)
//                print("Error :: \(error.debugDescription)")
//                print("Response :: \(response.debugDescription)")
                return
            }
            self.setImageData(image: image, key: key)
        }
        task.resume()
    }
    
    func setImageData(image: UIImage, key: String) {
        DispatchQueue.main.async {
            self.image = image
        }
        self.cacheManager.addImageToCache(key: key, image: image)
        self.localStorage.addImage(filename: key, image: image)
    }
    
}
