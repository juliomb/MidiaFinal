//
//  MovieCollection.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/11/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct MovieCollection: Decodable {

    let resultCount: Int
    let results: [Movie]?

}
