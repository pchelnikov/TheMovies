//
//  MoviesResponse.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/**
 Movies response handler (JSON parsing).
 */
enum MoviesResponse {
    case success(movies: [Movie])
    case failed(error: ApiError)
    
    /**
     Parses data from API response.
     
     - parameter jsonData: JSON as Data
     
     - returns: MoviesResponse
     */
    static func parse(_ jsonData: Data) -> MoviesResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)

        do {
            let results = try decoder.decode(MoviesResults.self, from: jsonData)
            return .success(movies: results.movies)
        } catch {
            debugPrint("💥 DECODE ERROR: \(error)")
            return .failed(error: .parseError)
        }
    }
}
