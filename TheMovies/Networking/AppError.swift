//
//  AppError.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

protocol AppError: Error {
    var description: String { get }
}

/// Common applicatin errors.
enum ApplicationError: AppError {
    case commonError, noResultsError, apiError(type: ApiErrorType)

    var description: String {
        switch self {
        case .commonError            : return "Common error"
        case .noResultsError         : return "No results"
        case .apiError(let apiError) : return apiError.description
        }
    }
}

/// Errors, which can occur while working with API.
enum ApiErrorType: AppError {
    case commonError, serverError, parseError, responseError

    var description: String {
        switch self {
        case .commonError   : return "Common API error"
        case .parseError    : return "Parse Error"
        case .responseError : return "Response Error"
        case .serverError   : return "Server Error"
        }
    }
}

