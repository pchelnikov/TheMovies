//
//  SearchScreenVM.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import RxCocoa
import RxSwift

final class SearchScreenVM: BaseViewModel {

    let loadNextData = BehaviorSubject<LoadOption>(value: LoadOption.fromStart)
    let endOfData = BehaviorRelay<Bool>(value: false)

    var lastQuery: String = ""
    
    var movies = [Movie]()
    var queriesHistory = [String]()
    
    private var currentPage: Int = 1
    
    override init() {
        super.init()
        
        if let history = QueriesHistoryService.getHistory(key: Config.Keys.queriesHistory) as? [String] {
            queriesHistory = history
        }
        
        loadNextData
            .skip(1)
            .subscribe(onNext: { [weak self] option in
                guard let `self` = self, self.lastQuery != "" else { return }
                self.getMovies(for: self.lastQuery, option: option)
            }).disposed(by: disposeBag)
    }
    
    private func getMovies(for query: String, option: LoadOption) {
        Observable.just(option)
            .do(onNext: { [weak self] option in self?.inProgress.onNext(true) })
            .flatMapFirst { [weak self] option -> Observable<(LoadOption, MoviesResponse)> in
                guard let `self` = self else { return Observable.empty() }
                
                switch option {
                case .fromStart:
                    self.currentPage = 1
                    return self.api.searchMovies(.searchMovies((query: query, page: self.currentPage))).map { r in (option, r) }
                case .continueLoading:
                    self.isPageLoading.accept(true)
                    self.currentPage += 1
                    return self.api.searchMovies(.searchMovies((query: query, page: self.currentPage))).map { r in (option, r) }
                case .paused:
                    return Observable.empty()
                }
            }
            .subscribe(onNext: { [weak self] option, response in
                self?.handleMoviesResponse(response, for: query, with: option)
            }, onError: { [weak self] (error) in
                self?.handleError(error)
            }).disposed(by: disposeBag)
    }
    
    private func handleMoviesResponse(_ response: MoviesResponse, for query: String, with option: LoadOption) {
        if case let .success(respMovies) = response {
            switch option {
            case .fromStart:
                movies = respMovies
                
                if respMovies.isEmpty {
                    self.handleError(ApplicationError.noResultsError)
                } else {
                    updateQueriesHistory(with: query)
                }
            case .continueLoading:
                movies += respMovies
            case .paused:
                break
            }
            
            endOfData.accept(respMovies.isEmpty)
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
    
    func historicalQuery(at indexPath: IndexPath) -> String? {
        return queriesHistory[safe: indexPath.row]
    }

    /// Updates history of queries.
    ///
    /// - Parameter query: The query, entered by user.
    private func updateQueriesHistory(with query: String) {
        guard var history = QueriesHistoryService.getHistory(key: Config.Keys.queriesHistory) as? [String] else {
            queriesHistory = [query]
            QueriesHistoryService.saveHistory(key: Config.Keys.queriesHistory, value: [query])
            return
        }
        
        if history.count == Config.maxQueriesHistoryCount {
            history.removeLast()
        }
        
        history.insert(query, at: 0)
        
        queriesHistory = history
        
        QueriesHistoryService.saveHistory(key: Config.Keys.queriesHistory, value: history)
    }
}
