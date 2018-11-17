//
//  Config.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/**
 Structure for constants declaration.
 */
struct Config {

    static let apiKey = "6c52966d9be717e486a2a0c499867009"
    
    static let maxQueriesHistoryCount = 10

    struct URL {
        static let base = "http://api.themoviedb.org/3"
        static let basePoster = "http://image.tmdb.org/t/p"
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
