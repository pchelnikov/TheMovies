//
//  Dependencies.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

final class Dependencies {

    static let shared = Dependencies()

    var api: TheMovieDBApi

    init() {
        let apiManager = APIManager(session: URLSession(configuration: .default))
        self.api = TheMovieDBApi(manager: apiManager)
    }
}
