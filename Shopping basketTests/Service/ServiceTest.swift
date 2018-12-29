//
//  ServiceTest.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 27/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class ServiceTest: XCTestCase {

    var service: CurrencyService?
    
    override func setUp() {
        service = CurrencyService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testcurrencyList() {
        let endQueryExpectation = expectation(description: "EndQueryExpectation")
        service?.getCurrencyList(handler: { (currencyList, error) in
            if let _error = error {
                XCTAssert(false, _error.message)
                endQueryExpectation.fulfill()
            } else {
                if let list = currencyList {
                    XCTAssertGreaterThan(list.count, 0, "Empty currency list response")
                    endQueryExpectation.fulfill()
                }
            }
            
        })
        wait(for: [endQueryExpectation], timeout: 5.0)
    }
    
    func testConvertation() {
         let endQueryExpectation = expectation(description: "EndQueryExpectation")
            service?.convertCurrency(from: "USD", to: "EUR", handler: { (multiplier, error) in
                if let _error = error {
                    XCTAssert(false, _error.message)
                    endQueryExpectation.fulfill()
                } else {
                    XCTAssertNotNil(multiplier, "Multiplier is nil")
                    endQueryExpectation.fulfill()
                }
            })
        wait(for: [endQueryExpectation], timeout: 5.0)
    }
    
    func testApiKeyParameter() {
        let endQueryExpectation = expectation(description: "EndBadQueryExpectation")
        let networkRouter = Router<CurrencyAPI>()
        networkRouter.request(.currencyList) {(data, response, error) in
            guard let _data = data else {return}
            do {
             guard let jsonResponse = try JSONSerialization.jsonObject(with: _data , options: []) as? [String : Any] else {
                return
                }
            if let error = jsonResponse["error"] as? [String: Any],
                let code = error["code"] as? Int,
                let info = error["info"] as? String {
                    XCTAssertEqual(code, 101, "Access key error")
                    XCTAssertEqual(info, "You have not supplied an API Access Key. [Required format: access_key=YOUR_ACCESS_KEY]",
                               "Access key error")
             }
            endQueryExpectation.fulfill()
            }
            catch { XCTAssert(false, "Serialization error") }
        }
        wait(for: [endQueryExpectation], timeout: 5.0)
    }
}
