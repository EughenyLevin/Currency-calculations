//
//  CurrencyService.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

typealias currListHandler = ([Currency]?, ErrorModel?)->()
typealias currConverterHandler = (Double?, ErrorModel?)->()

class CurrencyService {

    private let networkRouter = Router<CurrencyAPI>()
    
    func getCurrencyList(handler: @escaping currListHandler)  {
        networkRouter.request(.currencyList) {[unowned self] (data, response, error) in
            if error != nil { handler(nil, ErrorModel.init(title: "", message: "Please check your connection")) }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let dataResponse = data else {
                        handler(nil, ErrorModel(title: "Attention", message: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        guard let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse , options: []) as? [String : Any] else {
                            handler(nil, ErrorModel(title: "Attention", message: NetworkResponse.unableToDecode.rawValue))
                            return
                        }
                        if let jsonCurrency = jsonResponse["currencies"] as? [String : String] {
                            handler(self.cuurencyListFrom(jsonCurrency), nil)
                        }
                    } catch {
                        handler(nil, ErrorModel(title: "Attention", message: NetworkResponse.unableToDecode.rawValue))
                        return
                    }
                case .failure(let error):
                    handler(nil, ErrorModel(title: "Attention", message: error))
                }
            }
        }
    }
    
    func convertCurrency(from baseISO: String, to selectedISO: String, handler: @escaping currConverterHandler)  {
        networkRouter.request(.currencyConvert(selectedISO,baseISO)) {[unowned self] (data, response, error) in
            if error != nil { handler(nil, ErrorModel.init(title: "", message: "Please check your connection")) }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let dataResponse = data else {
                        handler(nil, ErrorModel(title: "Attention", message: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        guard let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse , options: []) as? [String : Any] else {
                            handler(nil, ErrorModel(title: "Attention", message: NetworkResponse.unableToDecode.rawValue))
                            return
                        }
                        if let jsonCurrency = jsonResponse["quotes"] as? [String : Double] {
                            handler(jsonCurrency.values.first, nil)
                        }
                    } catch {
                        handler(nil, ErrorModel(title: "Attention", message: NetworkResponse.unableToDecode.rawValue))
                        return
                    }
                case .failure(let error):
                    handler(nil, ErrorModel(title: "Attention", message: error))
                }
            }
        }
    }
}

extension CurrencyService {
 
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default:  return .failure(NetworkResponse.failed.rawValue)
            
        }
    }
    
    fileprivate func cuurencyListFrom(_ jsonList: [String: String]) -> [Currency] {
        var currencies = Array<Currency>()
        for (code, description) in jsonList {
            let currency = Currency(shortTitle: code, fullTitle: description)
            currencies.append(currency)
        }
        return currencies
    }
}
