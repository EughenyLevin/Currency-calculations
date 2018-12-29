//
//  CurrencyAPI.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

enum CurrencyAPI {
    case currencyList
    case currencyConvert(String, String)
}

extension CurrencyAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: NetworkConstant.baseURL) else { fatalError("Base URL not cofigured")}
        return url
    }
    
    var path: String {
        switch self {
        case .currencyList: return NetworkConstant.currencyList
        case .currencyConvert: return NetworkConstant.currencyRate
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .currencyList:
            return .get
        case .currencyConvert:
            return .get
        }
    }
    
    var task: HTTPTask {
        let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist")
        let plist    = NSDictionary(contentsOfFile: filePath!)
        let apiKey: String = plist?.object(forKey: "ApiKey") as! String
        
        switch  self {
        case .currencyList:
            return .requestParameters(bodyParams: nil, urlParams: ["access_key": apiKey])
        case .currencyConvert(let isoSelected, let isoDefault):
            return .requestParameters(bodyParams: nil, urlParams: ["access_key": apiKey,
                                                                   "source": isoDefault,
                                                                   "currencies": isoSelected])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

