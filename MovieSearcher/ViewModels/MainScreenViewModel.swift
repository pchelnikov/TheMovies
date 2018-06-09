//
//  MainScreenViewModel.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift

final class MainScreenViewModel {
    
    private var dBag = DisposeBag()
    
    init() {
        
    }
    
    func getMovies() {
        
        APIManager.shared.getMovies(for: "world")
            .subscribe(onNext: { (response) in
                debugPrint(response)
            }, onError: { (error) in
                debugPrint(error)
            }).disposed(by: dBag)
    }
}
