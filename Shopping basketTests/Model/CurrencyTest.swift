//
//  CurrencyTest.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 29/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class CurrencyTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrencyInit()  {
        var currency: Currency?
        let jsonList = ["EUR": "Euro"]
        for (code, description) in jsonList {
            currency = Currency(shortTitle: code, fullTitle: description)
        }
        XCTAssertNotNil(currency, "Cannot init currency")
    }

}
