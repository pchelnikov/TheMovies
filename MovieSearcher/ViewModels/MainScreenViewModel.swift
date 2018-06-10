//
//  MainScreenViewModel.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

final class MainScreenViewModel: BaseViewModel {
    
    var movies = [Movie]()
    
    var rowsCount: Int {
        return movies.count
    }
    
    override init() {
        
    }
    
    func getMovies(for query: String) {
        inProgress.onNext(true)
        
        APIManager.shared.getMovies(for: query, page: 1)
            .subscribe(onNext: { [weak self] (response) in
                guard let `self` = self else { return }
                
                if case let .success(movies) = response {
                    self.movies = movies
                    self.isEmptyData.accept(movies.isEmpty)
                    self.dataRefreshed.onNext(())
                    self.inProgress.onNext(false)
                } else {
                    //error
                }
            }, onError: { (error) in
                debugPrint(error)
            }).disposed(by: dBag)
    }

    func movieItemAt(indexPath: IndexPath) -> Movie? {
        return movies[safe: indexPath.row]
    }
}
