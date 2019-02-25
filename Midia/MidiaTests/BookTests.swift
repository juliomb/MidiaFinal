//
//  BookTests.swift
//  MidiaTests
//
//  Created by Julio Martínez Ballester on 2/25/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest

class BookTests: XCTestCase {

    var bestBookEver: Book = Book(bookId: "1", title: "El nombre del viento", authors: ["Patrick Rothfuss"], publishedDate: Date(timeIntervalSinceNow: 13213), description: "Kvothe rules", coverURL: nil, rating: 5, numberOfReviews: 2131, price: 10)

    func testBookExistence() {
        XCTAssertNotNil(bestBookEver)
    }

    func testDecodeBookCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "book-search-response", ofType: "json") else {
            XCTFail()
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let bookCollection = try decoder.decode(BookCollection.self, from: data)
            XCTAssertNotNil(bookCollection)
        } catch {
            XCTFail()
        }
    }

}
