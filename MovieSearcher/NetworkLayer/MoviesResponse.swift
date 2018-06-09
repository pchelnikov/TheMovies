//
//  MoviesResponse.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

enum MoviesResponse {
    case success(movies: [Movie])
    case failed(error: ApiError)
    
    static func parse(_ jsonData: Data) -> MoviesResponse {
        let decoder = JSONDecoder()
        
        do {
            let results = try decoder.decode(MoviesResults.self, from: jsonData)
            return .success(movies: results.movies)
        } catch {
            debugPrint("💥 DECODE ERROR: \(error)")
            return .failed(error: .parseError)
        }
    }
}
