//
//  Movie.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/**
 Data structure for movie object.
 */
struct Movie: Equatable {
    
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: Date?
}
