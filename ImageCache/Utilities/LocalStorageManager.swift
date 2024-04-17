//
//  LocalStorageManager.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import Foundation
import UIKit

class LocalStorageManager {
    let fileManager = FileManager.default
    let imagesDirectory = "local_images"
    static let instance = LocalStorageManager()
    private init() {
        createDirectory()
    }
    
    func createDirectory() {
        guard let path = getFolderPath() else {
            return
        }
        if !fileManager.fileExists(atPath: path.path) {
            do {
                try fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error)")
            }
        }
    }
    
    func getFolderPath() -> URL? {
        guard let documentsURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsURL.appendingPathComponent(imagesDirectory)
    }
    
    func addImage(filename: String, image: UIImage?) {
        guard let path = getFolderPath(), let image = image else {
            return
        }
        let imgPath = path.appendingPathComponent("\(filename).jpg")
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        do {
         try! data.write(to: imgPath)
        }
    }
    
    func getImage(filename: String) -> UIImage? {
        guard let path = getFolderPath() else {
            return nil
        }
        let imgPath = path.appendingPathComponent("\(filename).jpg")
        if fileManager.fileExists(atPath: imgPath.path){
            do {
                let data = try! Data(contentsOf: imgPath)
                return UIImage(data: data)
            }
        } else {
            return nil
        }
    }
}

