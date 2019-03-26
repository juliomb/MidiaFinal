//
//  iTunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import Alamofire

class ITunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {

    enum ErrorITunes: Error {
        case notFound
    }

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        Alamofire.request(ITunesMoviesAPIConstants.absoluteURL(withQueryParamas: ["top"])).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                        success(movieCollection.results ?? []) // NO HACE FALTA DISPATCH IN MAIN THREAD
                    } catch {
                        failure(error) // Error parseando, lo enviamos directamente, no es el mismo que taskError
                    }
                } else {
                    success([])
                }
            }
        }

    }

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        let paramsArray = queryParams.components(separatedBy: " ")

        Alamofire.request(ITunesMoviesAPIConstants.absoluteURL(withQueryParamas: paramsArray)).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                        success(movieCollection.results ?? []) // NO HACE FALTA DISPATCH IN MAIN THREAD
                    } catch {
                        failure(error) // Error parseando, lo enviamos directamente
                    }
                } else {
                    success([])
                }
            }
        }
    }

    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {

        Alamofire.request(ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)).responseData { (response) in

            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                        if let movie = movieCollection.results?.first {
                            success(movie)
                        } else {
                            failure(ErrorITunes.notFound)
                        }
                    } catch {
                        failure(error) // Error parseando, lo enviamos directamente
                    }
                } else {
                    fatalError("Expected data on a success call retriving a book by id \(mediaItemId)")
                }
            }

        }
    }

}
