
//
//  URLParametersEncoder.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

public struct URLParametersEncoder: ParameterEncoding {
    static func encode(request: inout URLRequest, with params: Parameters) throws {
        guard let url = request.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !params.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key,value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)"
                    .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/x-ww-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
