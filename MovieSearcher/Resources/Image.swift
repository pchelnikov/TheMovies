//
//  Image.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

struct Image {
    static func by(assetId: ImageAssetId) -> UIImage? {
        return UIImage(named: assetId.rawValue)
    }
}

enum ImageAssetId: String, EnumCollection {

    //TabBar
    case tabBarDiscoverNormal, tabBarFavoritesNormal, tabBarSearchNormal
    case tabBarDiscoverSelected, tabBarFavoritesSelected, tabBarSearchSelected

    //Common
    case disclosureIndicator, iconReleaseFrame
}
