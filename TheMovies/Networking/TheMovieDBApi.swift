//
//  TheMovieDBApi.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

final class TheMovieDBApi {

    let manager: APIManager

    init(manager: APIManager) {
        self.manager = manager
    }

    /**
     Gets the movies list.

     - parameter query: The query, entered by user.
     - parameter page: Page of list.

     - returns: Observable of MoviesResponse.
     */
    func searchMovies(_ endpoint: TheMovieDBEndpoint) -> Observable<MoviesResponse> {
        return manager.request(for: endpoint)
            .debug()
            .map(MoviesResponse.parse)
    }

    /**
     Gets the most popular movies.

     - returns: Observable of MoviesResponse.
     */
    func discoverPopularMovies(_ endpoint: TheMovieDBEndpoint) -> Observable<MoviesResponse> {
        return manager.request(for: endpoint)
            .debug()
            .map(MoviesResponse.parse)
    }

    /**
     Gets the movie details.

     - returns: Observable of MovieDetailsResponse.
     */
    func getMovieDetails(_ endpoint: TheMovieDBEndpoint) -> Observable<MovieDetailsResponse> {
        return manager.request(for: endpoint)
            .debug()
            .map(MovieDetailsResponse.parse)
    }
}
