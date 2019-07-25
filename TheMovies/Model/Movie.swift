//
//  Movie.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/// Data structure for movie object.
struct Movie: Equatable {

    let id: Int64?
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: Date?
}

extension Movie: Decodable {

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath  = "poster_path"
        case releaseDate = "release_date"
    }

    init?(data: Data) {
        guard let me = try? JSONDecoder.theMovieDB.decode(Movie.self, from: data) else { return nil }
        self = me
    }
}
