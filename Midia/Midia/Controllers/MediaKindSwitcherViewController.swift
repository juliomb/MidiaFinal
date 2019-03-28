//
//  MediaKindSwitcherViewController.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/28/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class MediaKindSwitcherViewController: UIViewController {

    @IBOutlet weak var booksButton: UIButton!
    @IBOutlet weak var moviesButton: UIButton!

    var selectedMediaItemKind: MediaItemKind!

    override func viewDidLoad() {
        setup(withMediaItemKind: selectedMediaItemKind)
    }

    @IBAction func didTapBooksButton(_ sender: Any) {
        setup(withMediaItemKind: .book)
    }

    @IBAction func didTapMoviesButton(_ sender: Any) {
        setup(withMediaItemKind: .movie)
    }

    func setup(withMediaItemKind mediaItemKind: MediaItemKind) {
        guard let tabBarController = tabBarController as? MidiaTabController else {
            return
        }
        selectedMediaItemKind = mediaItemKind
        switch mediaItemKind {
        case .book:
            booksButton.isEnabled = false
            moviesButton.isEnabled = true
        case .movie:
            moviesButton.isEnabled = false
            booksButton.isEnabled = true
        default:
            fatalError("not supported yet :(")
        }

        tabBarController.update(withMediaItemKind: selectedMediaItemKind)
    }

}
