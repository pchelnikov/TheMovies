//
//  MoviesResults.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/**
 Data structure for movies search results.
 */
struct MoviesResults {
    
    let movies: [Movie]
}

extension MoviesResults: Decodable {

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

    init?(data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
        guard let me = try? decoder.decode(MoviesResults.self, from: data) else { return nil }
        self = me
    }
}
