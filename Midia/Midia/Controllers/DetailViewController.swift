//
//  DetailViewController.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/5/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var ratingsContainerView: UIView!

    @IBOutlet weak var loadingView: UIView!

    var mediaItemId: String!
    var mediaItemProvider: MediaItemProvider!
    var detailedMediaItem: MediaItemDetailedProvidable?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mediaItemProvider.getMediaItem(byId: mediaItemId, success: { [weak self] (detailedMediaItem) in
            self?.loadingView.isHidden = true
            self?.detailedMediaItem = detailedMediaItem
            self?.syncViewWithModel()
        }) { [weak self] (error) in
            self?.loadingView.isHidden = true
            // Creo una alerta, le añado acción con handler, presento la alerta
            let alertController = UIAlertController(title: nil, message: "Error recuperando media item.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self?.dismiss(animated: true, completion: nil)
            }))
            self?.present(alertController, animated: true, completion: nil)
        }
    }

    private func syncViewWithModel() {
        guard let mediaItem = detailedMediaItem else {
            return
        }

        // Obligatorio
        titleLabel.text = mediaItem.title

        // Me vale que sea nil
        descriptionTextView.text = mediaItem.description

        if let url = mediaItem.imageURL {
            imageView.loadImage(fromURL: url)
        }

        // Stack view, si lo tenemos lo pintamos, si no ocultamos el elemento para que la stack view reorganice
        if let creators = mediaItem.creatorName {
            creatorsLabel.text = creators
        } else {
            creatorsLabel.isHidden = true
        }

        if let rating = mediaItem.rating,
            let numberOfReviews = mediaItem.numberOfReviews {
            ratingLabel.text = "Rating \(rating)"
            numberOfReviewsLabel.text = "\(numberOfReviews) reviews"
        } else {
            ratingsContainerView.isHidden = true
        }

        if let creationDate = mediaItem.creationDate {
            creationDateLabel.text = DateFormatter.booksAPIDateFormatter.string(from: creationDate)
        } else {
            creationDateLabel.isHidden = true
        }

        if let price = mediaItem.price {
            buyButton.setTitle("Buy for \(price)$", for: .normal)
        } else {
            buyButton.isHidden = true
        }

    }

    // MARK: Actions

    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
