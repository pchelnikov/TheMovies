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
    var queriesHistory = [String]()
    
    var rowsCount: Int {
        return movies.count
    }
    
    override init() {
        if let history = QueriesHistoryService.getHistory(key: Config.Keys.queriesHistory) as? [String] {
            queriesHistory = history
        }
    }
    
    func getMovies(for query: String) {
        inProgress.onNext(true)
        
        APIManager.shared.getMovies(for: query, page: 1)
            .subscribe(onNext: { [weak self] (response) in
                guard let `self` = self else { return }
                
                if case let .success(movies) = response {
                    self.movies = movies
                    
                    if !movies.isEmpty {
                        self.updateQueriesHistory(with: query)
                    }
                    
                    self.dataRefreshed.onNext(movies.isEmpty)
                    self.inProgress.onNext(false)
                } else {
                    //error
                }
            }, onError: { (error) in
                debugPrint(error)
            }).disposed(by: dBag)
    }

    func movieItem(at indexPath: IndexPath) -> Movie? {
        return movies[safe: indexPath.row]
    }
    
    func historicalQuery(at indexPath: IndexPath) -> String? {
        return queriesHistory[safe: indexPath.row]
    }
    
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
