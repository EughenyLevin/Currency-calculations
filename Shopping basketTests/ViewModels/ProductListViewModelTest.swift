//
//  ProductListViewModelTest.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 27/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class ProductListViewModelTest: XCTestCase {

    var viewModel: ProductListViewModel?
    
    override func setUp() {
        viewModel = ProductListViewModel()
        viewModel?.createProducts()
        XCTAssertGreaterThan((viewModel?.productCount)!, 0, "No products found")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasketOperation() {
        let currentProduct = Product(title: "Peas", image: UIImage(named: "peas"), price: 0.95, currency: nil, dimension: "bag")
        viewModel?.addOrRemoveProduct(currentProduct, handler: { (isAdded) in
            })
        XCTAssertNotNil(viewModel?.findProduct(currentProduct).first, "Adding product error")
        
        if let foundProduct = viewModel?.findProduct(currentProduct).first {
            viewModel?.addOrRemoveProduct(foundProduct, handler: { (_) in })
            XCTAssertNotEqual(viewModel?.productCount, 1)
        }
    }
}
