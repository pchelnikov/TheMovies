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

    override init() {
        super.init()

        refreshData
            .do(onNext: { [weak self] option in self?.inProgress.onNext(true) })
            .flatMapFirst { APIManager.shared.discoverPopularMovies() }
            .do(onNext: { [weak self] _ in self?.inProgress.onNext(false) },
                onError: { [weak self] error in self?.handleError(error) })
            .map { r in r }
            .subscribe(onNext: { [weak self] response in
                debugPrint(response)
            }).disposed(by: disposeBag)

        refreshData.onNext(())
    }
}
