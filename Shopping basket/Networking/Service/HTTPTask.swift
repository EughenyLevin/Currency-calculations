//
//  HTTPTask.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParams: Parameters?, urlParams: Parameters?)
    case requestParametersAdditionalHeader(bodyParams: Parameters?, urlParams: Parameters?,
        additionHeaders: HTTPHeaders?)
}
