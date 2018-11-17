//
//  Collection+.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/**
 Extensions for Collection.
 */

extension Collection {
    
    subscript(safe index: Index) -> Iterator.Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
