//
//  TabBarViewController.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

enum TabBarItem {
    case discover, favorites, search

    var title: String {
        switch self {
        case .discover  : return "Discover"
        case .favorites : return "Favorites"
        case .search    : return "Search"
        }
    }
}

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    private func configureTabBar() {
        let discoverNavController = UINavigationController(rootViewController: UIViewController())
        let favoritesNavController = UINavigationController(rootViewController: UIViewController())
        let searchNavController = UINavigationController(rootViewController: MainScreenTableViewController())

        discoverNavController.tabBarItem = UITabBarItem(title: TabBarItem.discover.title,
                                                        image: Image.by(assetId: .tabBarDiscoverIcon),
                                                        tag: 0)

        favoritesNavController.tabBarItem = UITabBarItem(title: TabBarItem.favorites.title,
                                                         image: Image.by(assetId: .tabBarFavoritesIcon),
                                                         tag: 1)

        searchNavController.tabBarItem = UITabBarItem(title: TabBarItem.search.title,
                                                      image: Image.by(assetId: .tabBarSearchIcon),
                                                      tag: 2)

        viewControllers = [discoverNavController, favoritesNavController, searchNavController]
    }
}
