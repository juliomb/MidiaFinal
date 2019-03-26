//
//  MovieManaged+Mapping.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

extension MovieManaged {

    func mappedObject() -> Movie {

        let directorsList = directors?.map({ (director) -> String in
            let director = director as! Director
            return director.fullName!
        })

        let url: URL? = coverURL != nil ? URL(string: coverURL!) : nil

        return Movie(movieId: movieId!, title: title!, directors: directorsList, releasedDate: releasedDate, summary: summary, coverURL: url, rating: rating, numberOfReviews: Int(numberOfReviews), price: price)
    }

}
