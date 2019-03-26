//
//  Movie.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/11/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Movie {

    let movieId: String
    let title: String
    let directors: [String]?
    let releasedDate: Date?
    let summary: String?
    let coverURL: URL?
    let rating: Float?
    let numberOfReviews: Int?
    let price: Float?

    init(movieId: String, title: String, directors: [String]? = nil, releasedDate: Date? = nil, summary: String? = nil, coverURL: URL? = nil, rating: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.movieId = movieId
        self.title = title
        self.directors = directors
        self.releasedDate = releasedDate
        self.summary = summary
        self.coverURL = coverURL
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
    }

}

extension Movie: MediaItemProvidable {

    var mediaItemId: String {
        return movieId
    }

    var imageURL: URL? {
        return coverURL
    }

}

extension Movie: MediaItemDetailedProvidable {

    var creatorName: String? {
        return directors?.joined(separator: ", ")
    }

    var creationDate: Date? {
        return releasedDate
    }

    var description: String? {
        return summary
    }

}

extension Movie: Codable {

    enum CodingKeys: String, CodingKey {
        case movieId = "trackId"
        case title = "trackName"
        case directors = "artistName"
        case releaseDate
        case summary = "longDescription"
        case coverURL = "artworkUrl100"
        case price = "trackPrice"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let numericId = try container.decode(Int.self, forKey: .movieId)
        movieId = "\(numericId)"
        title = try container.decode(String.self, forKey: .title)
        directors = try container.decodeIfPresent(String.self, forKey: .directors)?.components(separatedBy: ",")
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate),
            let date = DateFormatter.iTunesAPIDateFormater.date(from: releaseDateString) {
            releasedDate = date
        } else {
            releasedDate = nil
        }
        summary = try container.decodeIfPresent(String.self, forKey: .summary)
        coverURL = try container.decodeIfPresent(URL.self, forKey: .coverURL)
        rating = nil
        numberOfReviews = nil
        price = try container.decodeIfPresent(Float.self, forKey: .price)

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(Int(movieId), forKey: .movieId)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(directors?.joined(separator: ", "), forKey: .directors)
        if let date = releasedDate {
            try container.encodeIfPresent(DateFormatter.iTunesAPIDateFormater.string(from: date), forKey: .releaseDate)
        }
        try container.encodeIfPresent(summary, forKey: .summary)
        try container.encodeIfPresent(coverURL, forKey: .coverURL)
        try container.encodeIfPresent(price, forKey: .price)
    }

}
