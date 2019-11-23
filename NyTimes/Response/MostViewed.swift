//
//  MostViewed.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import Foundation

struct MostViewed: Decodable {
    let status: String
    let results: [Result]
    enum CodingKeys: String, CodingKey {
        case results
        case status
    }
}
struct Result: Decodable {
    let adxKeywords: String
    let section, byline: String
    let title, abstract, publishedDate: String
    let media: [Media]
    enum CodingKeys: String, CodingKey {
        case adxKeywords = "adx_keywords"
        case section, byline, title, abstract
        case publishedDate = "published_date"
        case media
    }
}

struct Media: Codable {
    let mediaMetadata: [MediaMetadata]
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}
struct MediaMetadata: Codable {
    let url: String
    let height, width: Int
}
