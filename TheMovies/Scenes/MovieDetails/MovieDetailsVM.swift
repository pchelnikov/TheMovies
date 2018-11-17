//
//  MovieDetailsVM.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 12/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

final class MovieDetailsVM: BaseViewModel {

    let movieData = PublishSubject<Movie>()

    init(movieId: Int64) {
        super.init()

        Observable.just(movieId)
            .do(onNext: { [weak self] option in self?.inProgress.onNext(true) })
            .flatMapFirst { movieId in self.api.getMovieDetails(.getMovieDetails(movieId: movieId)) }
            .do(onNext: { [weak self] _ in self?.inProgress.onNext(false) },
                onError: { [weak self] error in self?.handleError(error) })
            .map { r in r }
            .subscribe(onNext: { [weak self] response in
                self?.handleResponse(response)
            }).disposed(by: disposeBag)
    }

    private func handleResponse(_ response: MovieDetailsResponse) {
        if case let .success(movie) = response {
            movieData.onNext(movie)
        } else {
            handleError(ApplicationError.commonError)
        }
    }
}
