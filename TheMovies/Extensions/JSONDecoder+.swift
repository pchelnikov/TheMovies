//
//  JSONDecoder+.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 14/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

extension JSONDecoder {

    /// Default JSON Decoder for The Movies DB.
    static let theMovieDB: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
        return decoder
    }()
}
