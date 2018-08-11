//
//  DiscoverVM.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import RxSwift

final class DiscoverVM: BaseViewModel {

    let refreshData = PublishSubject<()>()

    var movies = [Movie]()

    override init() {
        super.init()

        refreshData
            .do(onNext: { [weak self] option in self?.inProgress.onNext(true) })
            .flatMapFirst { APIManager.shared.discoverPopularMovies() }
            .do(onNext: { [weak self] _ in self?.inProgress.onNext(false) },
                onError: { [weak self] error in self?.handleError(error) })
            .map { r in r }
            .subscribe(onNext: { [weak self] response in
                self?.handleMoviesResponse(response)
            }).disposed(by: disposeBag)

        refreshData.onNext(())
    }

    private func handleMoviesResponse(_ response: MoviesResponse) { //}, for query: String, with option: LoadOption) {
        if case let .success(respMovies) = response {
//            switch option {
//            case .fromStart:
                movies = respMovies

                if respMovies.isEmpty {
                    self.handleError(ApplicationError.noResultsError)
                }
//            case .continueLoading:
//                movies += respMovies
//            case .paused:
//                break
//            }

//            endOfData.accept(respMovies.isEmpty)
            dataRefreshed.onNext(respMovies.isEmpty)
            isPageLoading.accept(false)
            inProgress.onNext(false)
        } else {
            self.handleError(ApplicationError.commonError)
        }
    }

    func movieItem(at indexPath: IndexPath) -> Movie? {
        return movies[safe: indexPath.row]
    }
}
