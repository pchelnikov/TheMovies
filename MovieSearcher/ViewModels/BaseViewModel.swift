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

typealias IsEmptyData = Bool

enum LoadOption {
    case fromStart
    case continueLoading
    case paused
}

class BaseViewModel {
    
    let visible     = BehaviorRelay<Bool>(value: false)
    let pageLoading = BehaviorRelay<Bool>(value: false)
    let isError     = BehaviorRelay<Bool>(value: false)
    
    let inProgress = PublishSubject<Bool>()
    
    var dataRefreshed = PublishSubject<IsEmptyData>()
    
    var loadNextData = BehaviorSubject<LoadOption>(value: LoadOption.fromStart)
    
    var dBag = DisposeBag()
}
