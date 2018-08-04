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
    
    static let maxQueriesHistoryCount = 10
    
    enum API {
        case searchMovie(SearchMovieParams)
        
        var url: String {
            switch self {
            case let .searchMovie(query: query, page: page):
                return "\(URL.base)&query=\(query)&page=\(page)"
            }
        }
    }
    
    struct URL {
        static let base = "http://api.themoviedb.org/3/search/movie?api_key=6c52966d9be717e486a2a0c499867009"
        static let basePoster = "http://image.tmdb.org/t/p/w185"
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
