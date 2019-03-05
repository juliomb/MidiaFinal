//
//  MediaItemCollectionViewCell.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/26/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class MediaItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    var mediaItem: MediaItemProvidable! {
        didSet {
            titleLabel.text = mediaItem.title
            if let url = mediaItem.imageURL {
                imageView.loadImage(fromURL: url)
            }
        }
    }

}
