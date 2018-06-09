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
        
        APIManager.shared.getMovies(for: "world", page: 1)
            .subscribe(onNext: { (response) in
                debugPrint(response)
            }, onError: { (error) in
                debugPrint(error)
            }).disposed(by: dBag)
        
//        URLSession.shared.rx.response(request: request)
//            .subscribe(onNext: { (response, data) in
//                debugPrint(response)
//                debugPrint(data)
//            }, onError: { (error) in
//                debugPrint(error)
//            }).disposed(by: dBag)
        
        
//            .debug()
//            .flatMap { (response, data) -> Observable<String> in
//
//            }
        
//            .flatMap { (arg: (response: HTTPURLResponse, data: Data)) -> Observable<String> in
//
//                let (data, response) = arg
//                if let response = response as? HTTPURLResponse {
//                    if 200 ..< 300 ~= response.statusCode {
//                        return just(transform(data))
//                    }
//                    else {
//                        return Observable.error(yourNSError)
//                    }
//                }
//                else {
//                    rxFatalError("response = nil")
//                    return Observable.error(yourNSError)
//                }
//            }
//            .subscribe { event in
//                print(event) // if error happened, this will also print out error to console
//            }
    }
}
