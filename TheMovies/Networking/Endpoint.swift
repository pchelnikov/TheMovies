//
//  Endpoint.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

typealias SearchMovieParams = (query: String, page: Int)

enum TheMovieDBEndpoint {
    case searchMovies(SearchMovieParams)
    case discoverPopularMovies(page: Int)
    case getMovieDetails(movieId: Int64)
}

extension TheMovieDBEndpoint: Endpoint {
    var path: String {
        switch self {
        case let .searchMovies(query: query, page: page):
            return "\(Config.URL.base)/search/movie?api_key=\(Config.apiKey)&query=\(query)&page=\(page)"
        case let .discoverPopularMovies(page: page):
            return "\(Config.URL.base)/discover/movie?api_key=\(Config.apiKey)&page=\(page)&sort_by=popularity.desc"
        case let .getMovieDetails(movieId: movieId):
            return "\(Config.URL.base)/movie/\(movieId)?api_key=\(Config.apiKey)&language=en-US"
        }
    }
}
