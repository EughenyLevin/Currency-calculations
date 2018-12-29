//
//  ParameterEncoding.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public enum NetworkError: String, Error {
    case parametersNil  = "Parameters nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL     = "URL is absent"
}

protocol ParameterEncoding {
    static func encode(request: inout URLRequest, with params: Parameters) throws
}
