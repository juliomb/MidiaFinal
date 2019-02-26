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

        let volumeInfoContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        title = try volumeInfoContainer.decode(String.self, forKey: .title)
        authors = try volumeInfoContainer.decodeIfPresent([String].self, forKey: .authors)
        if let publishedDateString = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .publishedDate) {
            publishedDate = DateFormatter.booksAPIDateFormatter.date(from: publishedDateString)
        } else {
            publishedDate = nil
        }
        description = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .description)

        // Es posible que no haya imageLinkContainer, entonces ponemos try? para asegurarnos que está al hacer el decode.
        let imageLinkContainer = try? volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
        coverURL = try imageLinkContainer?.decodeIfPresent(URL.self, forKey: .coverURL)

        rating = try volumeInfoContainer.decodeIfPresent(Float.self, forKey: .rating)
        numberOfReviews = try volumeInfoContainer.decodeIfPresent(Int.self, forKey: .numberOfReviews)

        let saleInfoContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        let listPriceContainer = try? saleInfoContainer?.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        price = try listPriceContainer??.decodeIfPresent(Float.self, forKey: .price)
    }

}
