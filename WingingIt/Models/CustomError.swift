//
//  CustomError.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import Foundation

enum TemplateError: Error, LocalizedError {
    case emptyQuestion
    case duplicateQuestion
    case emptyOption
    case insufficientOptions
    case duplicateOption
    
    var errorDescription: String? {
        switch self {
        case .emptyQuestion:
            "Enter your question"
        case .duplicateQuestion:
            "This question template already exists."
        case .emptyOption:
            "Enter your option"
        case .insufficientOptions:
            "Insufficient options provided. At least two options are required."
        case .duplicateOption:
            "Identical options are not allowed."
        }
    }
}

enum MultiOptionsError: Error, LocalizedError {
    case invalidOptionFormat
    case duplicateOption
    
    var errorDescription: String? {
        switch self {
        case .invalidOptionFormat:
            "Option format is incorrect. Please follow the input criteria."
        case .duplicateOption:
            "Identical options are not allowed."
        }
    }
}

enum NumGenError: Error, LocalizedError {
    case insufficientCandidates
    case invalidNumberRange
    
    var errorDescription: String? {
        switch self {
        case .insufficientCandidates:
            "One or more patterns are invalid. Please check the range and count of all patterns marked with unique results."
        case .invalidNumberRange:
            "Invalid range. Please ensure that the lower bound is less than the upper bound."
        }
    }
}
