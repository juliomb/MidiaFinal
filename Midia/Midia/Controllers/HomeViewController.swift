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

    @IBOutlet weak var collectionView: UICollectionView!

}

extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // TODO
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError()
        }
        cell.titleLabel.text = "Hola mundo!!!"
        return cell
    }

}
