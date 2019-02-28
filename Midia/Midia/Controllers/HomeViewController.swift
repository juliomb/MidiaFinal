//
//  HomeViewController.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let mediaItemCellIdentifier = "mediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mediaItems = mediaItemProvider.getHomeMediaItems()
    }

}

extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError()
        }
        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }

}
