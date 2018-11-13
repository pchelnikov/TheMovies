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
    case failed(error: ApiError)

    /**
     Parses data from API response.

     - parameter jsonData: JSON as Data

     - returns: MoviesResponse
     */
    static func parse(_ jsonData: Data) -> MovieDetailsResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)

        do {
            let movie = try decoder.decode(Movie.self, from: jsonData)
            return .success(movie: movie)
        } catch {
            debugPrint("💥 DECODE ERROR: \(error)")
            return .failed(error: .parseError)
        }
    }
}
