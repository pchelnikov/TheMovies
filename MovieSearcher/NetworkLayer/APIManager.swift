//
//  APIManager.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

enum ApiError: Error {
    case commonError
    case serverError
    case parseError
    case responseError
}

final class APIManager {
    
    static let shared = APIManager()
    
    func getMovies(for query: String, page: Int) -> Observable<MoviesResponse> {
        guard let url = URL(string: Config.API.searchMovieURL((query: query, page: page)).url) else {
            return Observable.just(MoviesResponse.failed(error: .commonError))
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.data(request: request)
            .debug()
            .map(MoviesResponse.parse)
            .catchErrorJustReturn(MoviesResponse.failed(error: .responseError))
    }
}
