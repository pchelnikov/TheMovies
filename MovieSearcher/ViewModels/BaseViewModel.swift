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

typealias InProgress = Bool
typealias IsEmptyData = Bool

class BaseViewModel {
    
    let isPageLoading = BehaviorRelay<Bool>(value: false)
    let endOfData = BehaviorRelay<Bool>(value: false)
    
    let inProgress = PublishSubject<InProgress>()
    var dataRefreshed = PublishSubject<IsEmptyData>()
    let onError = PublishSubject<ApplicationError>()
    
    var loadNextData = BehaviorSubject<LoadOption>(value: LoadOption.fromStart)
    
    var dBag = DisposeBag()
}
