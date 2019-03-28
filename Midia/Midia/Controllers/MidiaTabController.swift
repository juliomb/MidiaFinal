//
//  MidiaTabController.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/28/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class MidiaTabController: UITabBarController {

    var selectedMediaItemKind: MediaItemKind!

    func setup(withMediaItemKind mediaItemKind: MediaItemKind) {
        guard let homeViewController = viewControllers?.first as? HomeViewController,
            let searchViewController = viewControllers?[1] as? SearchViewController,
            let mediaItemSwitcherViewController = viewControllers?.last as? MediaKindSwitcherViewController else {
                return
        }

        selectedMediaItemKind = mediaItemKind
        let mediaItemProvider = MediaItemProvider(withMediaItemKind: selectedMediaItemKind)
        homeViewController.mediaItemProvider = mediaItemProvider
        searchViewController.mediaItemProvider = mediaItemProvider
        mediaItemSwitcherViewController.selectedMediaItemKind = mediaItemKind

        StorageManager.setup(withMediaItemKind: mediaItemKind)
    }

    func update(withMediaItemKind mediaItemKind: MediaItemKind) {
        guard selectedMediaItemKind != mediaItemKind,
            let homeViewController = viewControllers?.first as? HomeViewController,
            let searchViewController = viewControllers?[1] as? SearchViewController,
            let favoritesViewController = viewControllers?[2] as? FavoritesViewController else {
            return
        }

        selectedMediaItemKind = mediaItemKind
        let newItemProvider = MediaItemProvider(withMediaItemKind: selectedMediaItemKind)
        homeViewController.mediaItemProvider = newItemProvider
        homeViewController.reset()
        searchViewController.mediaItemProvider = newItemProvider
        searchViewController.reset()

        StorageManager.setup(withMediaItemKind: mediaItemKind)
        favoritesViewController.reset()
    }

}

