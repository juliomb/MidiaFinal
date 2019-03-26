//
//  ITunesMoviesAPIConsumerURLSession.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class ITunesMoviesAPIConsumerURLSession: MediaItemAPIConsumable {

    let session = URLSession.shared

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let url = ITunesMoviesAPIConstants.absoluteURL(withQueryParams: ["best"])
        let task = session.dataTask(with: url) { (data, response, error) in
            // Si hay error, lo paso para arriba con la closure de failure
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results ?? []) }
                } catch {
                    DispatchQueue.main.async { failure(error) } // Error parseando, lo enviamos para arriba
                }
            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        task.resume()
    }

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        let paramsArray = queryParams.components(separatedBy: " ")
        let url = ITunesMoviesAPIConstants.absoluteURL(withQueryParams: paramsArray)
        let task = session.dataTask(with: url) { (data, response, error) in
            // Si hay error, lo paso para arriba con la closure de failure
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results ?? []) }
                } catch {
                    DispatchQueue.main.async { failure(error) } // Error parseando, lo enviamos para arriba
                }
            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        task.resume()

    }

    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {

        let url = ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)
        let task = session.dataTask(with: url) { (data, response, error) in
            // Si hay error, lo paso para arriba con la closure de failure
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async {
                        if let movie = movieCollection.results?.first {
                            success(movie)
                        } else {
                            failure(ErrorITunes.notFound)
                        }
                    }
                } catch {
                    DispatchQueue.main.async { failure(error) } // Error parseando, lo enviamos para arriba
                }
            } else {
                fatalError("Expected data on a success call retriving a movie by id \(mediaItemId)")
            }
        }
        task.resume()
    }


}
