//
//  APIManager.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

final class APIManager {
    
    static let shared = APIManager()
    
    private func call(url: String) -> Observable<Data> {
        guard let url = URL(string: url) else {
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
    
    func getMovies(for query: String, page: Int) -> Observable<MoviesResponse> {
        return call(url: Config.API.searchMovieURL((query: query, page: page)).url)
            .debug()
            .map(MoviesResponse.parse)
    }
}
