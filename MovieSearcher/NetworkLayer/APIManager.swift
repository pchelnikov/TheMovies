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
    case serverError
}

final class APIManager {
    
    static let shared = APIManager()
    
    func getMovies(for query: String) -> Observable<MoviesResponse> {
        guard let url = URL(string: Config.API.searchMovieURL) else {
            return Observable.empty()
        }
        
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.json(request: request) //.response(request: request)
            .debug()
            .map(MoviesResponse.parse)
            .catchErrorJustReturn(MoviesResponse.failed)
    }
}

enum MoviesResponse: Equatable {
    case success
    case failed
    
    // MARK: JSON
    static func parse(_ json: Any) -> MoviesResponse {
        guard let dict = json as? [String : AnyObject] else { return .failed }
        
        debugPrint(dict)
        
        return .success
    }
}
