//
//  MovieDetailsResponse.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 12/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/**
 Movie Details response handler (JSON parsing).
 */
enum MovieDetailsResponse {
    case success(movie: Movie)
    case failed(error: ApiErrorType)

    /**
     Parses data from API response.

     - parameter jsonData: JSON as Data

     - returns: MoviesResponse
     */
    static func parse(_ jsonData: Data) -> MovieDetailsResponse {
        guard let movie = Movie(data: jsonData) else {
            debugPrint("💥 DECODING ERROR: Movie")
            return .failed(error: .parseError)
        }
        return .success(movie: movie)
    }
}
