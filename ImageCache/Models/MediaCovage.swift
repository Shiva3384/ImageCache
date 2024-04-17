//
//  MediaCovage.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import Foundation

struct MediaCoverage: Identifiable, Codable {
    let id: String
    let title: String
    let language: String
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt: String
    let publishedBy: String
    let backupDetails: BackupDetails?
}

struct Thumbnail: Identifiable, Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Int
}

struct BackupDetails: Codable {
    let pdfLink: String
    let screenshotURL: String
}

/**
 {
     "id": "coverage-416f6c",
     "title": "Beating the clock starts with you",
     "language": "english",
     "thumbnail": {
       "id": "img-98ea7bac-444d-460e-b583-3c0f89a8863e",
       "version": 1,
       "domain": "https://cimg.acharyaprashant.org",
       "basePath": "images/img-98ea7bac-444d-460e-b583-3c0f89a8863e",
       "key": "image.jpg",
       "qualities": [
         10,
         20,
         30,
         40
       ],
       "aspectRatio": 1
     },
     "mediaType": 0,
     "coverageURL": "https://www.newindianexpress.com/lifestyle/spirituality/2024/Apr/13/beating-the-clock-starts-with-you",
     "publishedAt": "2024-04-14",
     "publishedBy": "The Indian Express",
     "backupDetails": {
       "pdfLink": "https://www.newindianexpress.com/lifestyle/spirituality/2024/Apr/13/beating-the-clock-starts-with-you",
       "screenshotURL": "https://www.newindianexpress.com/lifestyle/spirituality/2024/Apr/13/beating-the-clock-starts-with-you"
     }
   }
 */
