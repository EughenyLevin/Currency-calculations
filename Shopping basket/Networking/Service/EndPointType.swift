//
//  EndPointType.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    
    
    
    
}
