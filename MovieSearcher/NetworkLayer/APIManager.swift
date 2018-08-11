//
//  APIManager.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

/**
 Singleton class, which implements working with API.
 */
final class APIManager {
    
    static let shared = APIManager()
    
    /**
     General method for API calling.
     
     - parameter url: API url
     
     - returns: Observable of Response Data.
     */
    private func call(url: String) -> Observable<Data> {
        guard let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: escapedString) else {
            return Observable.error(ApplicationError.apiError(error: .commonError))
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.response(request: request)
            .flatMap({ (response, data) -> Observable<Data> in
                if 200 ..< 300 ~= response.statusCode {
                    return Observable.just(data)
                } else {
                    throw ApplicationError.apiError(error: .responseError)
                }
            })
    }
    
    /**
     Gets the movies list.
     
     - parameter query: The query, entered by user.
     - parameter page: Page of list.
     
     - returns: Observable of MoviesResponse.
     */
    func getMovies(for query: String, page: Int) -> Observable<MoviesResponse> {
        return call(url: Config.API.searchMovie((query: query, page: page)).url)
            .debug()
            .map(MoviesResponse.parse)
    }

    /**
     Gets the most popular movies.

     - returns: Observable of MoviesResponse.
     */
    func discoverPopularMovies() -> Observable<MoviesResponse> {
        return call(url: Config.API.discoverPopularMovies.url)
            .debug()
            .map(MoviesResponse.parse)
    }
}
