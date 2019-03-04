//
//  MediaItemProviderTests.swift
//  MidiaTests
//
//  Created by Julio Martínez Ballester on 3/4/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                success([MockMediaItem(), MockMediaItem()])
            }
        }
    }

}

struct MockMediaItem: MediaItemProvidable {
    var title: String = "A title"
    var imageURL: URL? = nil
}

class MediaItemProviderTests: XCTestCase {

    var mediaItemProvider: MediaItemProvider!
    var mockConsumer = MockMediaItemAPIConsumer()

    override func setUp() {
        super.setUp()

        mediaItemProvider = MediaItemProvider(withMediaItemKind: .book, apiConsumer: mockConsumer)
    }

    func testGetHomeMediaItems() {
        mediaItemProvider.getHomeMediaItems(onSuccess: { (mediaItems) in
            XCTAssertNotNil(mediaItems)
            XCTAssert(mediaItems.count > 0)
            XCTAssertNotNil(mediaItems.first?.title)
        }) { (_) in
            XCTFail()
        }
    }

}
