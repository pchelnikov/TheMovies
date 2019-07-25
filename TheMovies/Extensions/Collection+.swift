//
//  Collection+.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

extension Collection {

    /// Gets element from collection safely.
    ///
    /// - Parameter index: Index of element.
    subscript(safe index: Index) -> Iterator.Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
