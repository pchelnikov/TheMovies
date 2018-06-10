//
//  BaseViewModel.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

enum LoadOption {
    case fromStart
    case continueLoading
    case paused
}

class BaseViewModel {
    
    let visible     = BehaviorRelay<Bool>(value: false)
    let pageLoading = BehaviorRelay<Bool>(value: false)
    let isError     = BehaviorRelay<Bool>(value: false)
    let isEmptyData = BehaviorRelay<Bool>(value: true)
    
    let inProgress = PublishSubject<Bool>()
    
    var loadNextData  = BehaviorSubject<LoadOption>(value: LoadOption.fromStart)
    
    var dataRefreshed = PublishSubject<Void>()
    
    var dBag = DisposeBag()
}
