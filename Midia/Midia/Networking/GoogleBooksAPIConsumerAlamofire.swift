//
//  GoogleBooksAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/4/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import Alamofire

class GoogleBooksAPIConsumerAlamofire: MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        Alamofire.request(GoogleBooksAPIConstants.getAbsoluteURL(withQueryParams: ["2010"])).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: value)
                    success(bookCollection.items ?? [])
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            }
        }

    }

}
