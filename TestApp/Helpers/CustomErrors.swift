//
//  CustomErrors.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/24/21.
//

import Foundation

public enum CustomError: Error {
    case urlError
    case saveError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return NSLocalizedString("URL is invalid", comment: "")
        case .saveError:
            return NSLocalizedString("Can't save product", comment: "")
        }
    }
}
