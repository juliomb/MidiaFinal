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

    func getHomeMediaItems() -> [MediaItemProvidable] {
        // guardar en cache
        // comprobar que estamos hilo principal
        return apiConsumer.getLatestMediaItems()
    }

}

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getLatestMediaItems() -> [MediaItemProvidable] {
        return [Game()]
    }

}
