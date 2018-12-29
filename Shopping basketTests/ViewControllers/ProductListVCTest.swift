//
//  ProductListVCTest.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 27/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class ProductListVCTest: XCTestCase {

    var productListVC: ProductListController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        let productListVCNavi = storyboard.instantiateViewController(withIdentifier: "ProductListControllerNavi")
            as? UINavigationController
        XCTAssertNotNil(productListVCNavi, "Navigation controller not loaded")
        XCTAssertNotEqual(productListVCNavi?.viewControllers.count, 0,
                          "No controllers embled in navigation controller")
        productListVC = productListVCNavi?.topViewController as? ProductListController
        let _ = productListVC?.view
    }
    
    func testViewDidLoad() {
        XCTAssertNotNil(productListVC?.view, "ProductListController view not loaded")
    }
    
    func testMemoryWarning() {
        productListVC?.didReceiveMemoryWarning()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
