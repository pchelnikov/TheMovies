//
//  AppError.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 11/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

enum ApplicationError: Error {
    case commonError
    case noResultsError
    case apiError(error: ApiError)
    
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
