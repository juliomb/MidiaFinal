//
//  MovieTests.swift
//  MidiaTests
//
//  Created by Julio Martínez Ballester on 3/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest

class MovieTests: XCTestCase {

    var bestMovieEver: Movie!
    var detailedMovie: Movie!
    let coverURL = URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Video/v4/87/53/17/8753170e-df31-8d20-39c2-525e9ce0f3d6/source/30x30bb.jpg")


    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    override func setUp() {
        bestMovieEver = Movie(movieId: "1", title: "Forest Gump")
        detailedMovie = Movie(movieId: "2", title: "Batman", directors: ["Nolan"], releasedDate: Date(timeIntervalSince1970: 2323), summary: "The joker is f**ing crazy", coverURL: coverURL, rating: nil, numberOfReviews: nil, price: 19.9)
    }

    func testMovieExistence() {
        XCTAssertNotNil(bestMovieEver)
    }

    func testDecodeMovie() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "movie-search-response", ofType: "json") else {
            XCTFail()
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let movieCollection = try decoder.decode(MovieCollection.self, from: data)
            XCTAssertNotNil(movieCollection)
            let firstMovie = movieCollection.results?.first
            XCTAssertNotNil(firstMovie)
        } catch {
            XCTFail()
        }
    }

    func testEncodeBook() {
        do {
            let movieData = try encoder.encode(bestMovieEver)
            XCTAssertNotNil(movieData)
        } catch {
            XCTFail()
        }
    }

    func testDecodeEncodedDetailedBook() {
        do {
            let movieData = try encoder.encode(detailedMovie)
            XCTAssertNotNil(movieData)
            let movie = try decoder.decode(Movie.self, from: movieData)
            XCTAssertNotNil(movie)
            XCTAssertNotNil(movie.movieId)
            XCTAssertNotNil(movie.title)
            XCTAssertNotNil(movie.directors)
            XCTAssert(movie.directors!.count > 0)
            XCTAssertNotNil(movie.releasedDate)
            XCTAssertNotNil(movie.summary)
            XCTAssertNotNil(movie.coverURL)
            XCTAssertNotNil(movie.price)
        } catch {
            XCTFail()
        }
    }

}
