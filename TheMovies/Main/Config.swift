//
//  Config.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

typealias SearchMovieParams = (query: String, page: Int)

/**
 Structure for constants declaration.
 */
struct Config {

    static let apiKey = "6c52966d9be717e486a2a0c499867009"
    
    static let maxQueriesHistoryCount = 10
    
    enum API {
        case searchMovie(SearchMovieParams)
        case discoverPopularMovies(page: Int)
        case getMovieDetails(movieId: Int64)
        
        var url: String {
            switch self {
            case let .searchMovie(query: query, page: page):
                return "\(URL.base)/search/movie?api_key=\(Config.apiKey)&query=\(query)&page=\(page)"
            case let .discoverPopularMovies(page: page):
                return "\(URL.base)/discover/movie?api_key=\(Config.apiKey)&page=\(page)&sort_by=popularity.desc"
            case let .getMovieDetails(movieId: movieId):
                return "\(URL.base)/movie/\(movieId)?api_key=\(Config.apiKey)&language=en-US"
            }
        }
    }
    
    struct URL {
        static let base = "http://api.themoviedb.org/3"
        static let basePosterList = "http://image.tmdb.org/t/p/w300"
        static let basePosterDetails = "http://image.tmdb.org/t/p/w780"
    }
    
    struct Keys {
        static let queriesHistory = "_queriesHistory"
    }
    
    struct CellIdentifier {
        struct MovieTable {
            static let movieCell = "MovieItemCell"
            static let historyCell = "HistoryItemCell"
        }
    }
}
