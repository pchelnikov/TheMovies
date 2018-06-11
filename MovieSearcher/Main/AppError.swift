//
//  AppError.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 11/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

/**
 Errors, which can occur while working with API.
 */
enum ApiError: Error {
    case commonError, serverError, parseError, responseError
    
    var description: String {
        switch self {
        case .commonError:
            return "Please try again"
        case .parseError:
            return "Parese Error"
        case .responseError:
            return "Response Error"
        case .serverError:
            return "Server Error"
        }
    }
}

/**
 Custom applicatin errors.
 */
enum ApplicationError: Error {
    case commonError, noResultsError, apiError(error: ApiError)
    
    var description: String {
        switch self {
        case .commonError:
            return "Please try again"
        case .noResultsError:
            return "No results"
        case let .apiError(error: apiError):
            return apiError.description
        }
    }
}
