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
    
    enum API {
        case searchMovieURL(SearchMovieParams)
        
        var url: String {
            switch self {
            case let .searchMovieURL(query: query, page: page):
                return "\(URL.baseURL)&query=\(query)&page=1" //\(page)"
            }
        }
    }
    
    struct URL {
        static let baseURL = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838"
    }
}
