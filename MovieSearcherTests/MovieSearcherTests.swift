//
//  MovieSearcherTests.swift
//  MovieSearcherTests
//
//  Created by Mikhail Pchelnikov on 08/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import XCTest

@testable import MovieSearcher

class MovieSearcherTests: XCTestCase {
    
    func testImages() {
        var affectedAssetIds = [String]()

        for assetId in ImageAssetId.allCases() {
            if Image.by(assetId: assetId) == nil {
                affectedAssetIds.append(assetId.rawValue)
            }
        }

        if !affectedAssetIds.isEmpty {
            XCTFail("💥 Affected images: \n\(affectedAssetIds.map({ "💥 \($0)" }).joined(separator: "\n"))")
        }
    }    
}
