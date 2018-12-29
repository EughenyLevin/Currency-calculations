//
//  AppDelegateTests.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 26/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class AppDelegateTests: XCTestCase {
    
    var appDelegate: AppDelegate?
    
    override func setUp() {
        super.setUp()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        XCTAssertNotNil(appDelegate, "AppDelegate is nill")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLifeCycle() {
        appDelegate?.applicationWillResignActive(UIApplication.shared)
        
        appDelegate?.applicationDidEnterBackground(UIApplication.shared)
        
        appDelegate?.applicationWillEnterForeground(UIApplication.shared)
        
        appDelegate?.applicationDidBecomeActive(UIApplication.shared)
        
        appDelegate?.applicationWillTerminate(UIApplication.shared)
    }
}
