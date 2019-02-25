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
    let ratings: Float?
    let numberOfReviews: Int?
    let price: Float?

}
