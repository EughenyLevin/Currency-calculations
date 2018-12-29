//
//  NetworkRouter.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

enum NetworkResponse:String {
    case success
    case authenticationError = "Not authorized"
    case badRequest          = "Bad request"
    case outdated            = "The url request is outdated"
    case failed              = "Network request failed"
    case noData              = "Response returned with no data"
    case unableToDecode      = "Unable to decode the response"
}

enum Result<String> {
    case success
    case failure(String)
}

class Router<EndPoint: EndPointType> {
    
    private var task: URLSessionTask?
    private let timeInterval = 10.0
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: timeInterval)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue(NetworkConstant.JSONHeader, forHTTPHeaderField: NetworkConstant.HTTPHeaderContent)
            case .requestParameters(let bodyParams, let urlParams):
                try configureParameters(bodyParams: bodyParams, urlParams: urlParams, request: &request)
            case .requestParametersAdditionalHeader(let bodyParams, let urlParams, let additionHeaders):
                addAdditionalHeaders(additionHeaders, request: &request)
                try configureParameters(bodyParams: bodyParams, urlParams: urlParams, request: &request)
            }
            return request
        } catch  { throw error }
        
    }
    
    fileprivate func configureParameters(bodyParams: Parameters?,
                                          urlParams: Parameters?,
                                          request: inout URLRequest) throws {
        do {
            if let bodyParams = bodyParams {
                try JSONParametersEncoder.encode(request: &request, with: bodyParams)
            }
            if let urlParams = urlParams {
                try URLParametersEncoder.encode(request: &request, with: urlParams)
            }
        } catch (let error) { throw error }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

extension Router: NetworkRouter {
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                completion(data,response,error)
            })
        } catch  {
            completion(nil,nil,error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
