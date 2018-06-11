//
//  Config.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

typealias SearchMovieParams = (query: String, page: Int)

struct Config {
    
    static let maxQueriesHistoryCount = 10
    
    enum API {
        case searchMovieURL(SearchMovieParams)
        
        var url: String {
            switch self {
            case let .searchMovieURL(query: query, page: page):
                return "\(URL.base)&query=\(query)&page=\(page)"
            }
        }
    }
    
    struct URL {
        static let base = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838"
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
