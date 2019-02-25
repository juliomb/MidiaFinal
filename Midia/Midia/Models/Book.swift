//
//  Book.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/25/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Book {

    let bookId: String
    let title: String
    let authors: [String]?
    let publishedDate: Date?
    let description: String?
    let coverURL: URL?
    let rating: Float?
    let numberOfReviews: Int?
    let price: Float?

}

extension Book: Decodable {

    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case volumeInfo
        case title
        case authors
        case publishedDate
        case description
        case imageLinks
        case coverURL = "thumbnail"
        case rating = "averageRating"
        case numberOfReviews = "ratingsCount"
        case saleInfo
        case listPrice
        case price = "amount"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        bookId = try container.decode(String.self, forKey: .bookId)

        let volumeInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        title = try volumeInfo.decode(String.self, forKey: .title)

        // TODO: completar en casa o mañana
        authors = nil
        publishedDate = nil
        description = nil
        coverURL = nil
        rating = nil
        numberOfReviews = nil
        price = nil
    }

}
