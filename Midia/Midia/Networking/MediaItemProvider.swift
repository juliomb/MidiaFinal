//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/28/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class MediaItemProvider {

    let mediaItemKind: MediaItemKind
    let apiConsumer: MediaItemAPIConsumable

    private init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }

    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .game:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .movie:
            fatalError("MediaItemKind not supported yet :( coming soon")
        }
    }

    func getHomeMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // guardar en cache
        apiConsumer.getLatestMediaItems(onSuccess: { (mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }

}

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let queue = DispatchQueue.global()
        queue.async {
            // llama a la API de terceros
            Thread.sleep(forTimeInterval: 5)
            let mainQueue = DispatchQueue.main
            mainQueue.async {
                failure(nil)
            }
        }
    }

}
