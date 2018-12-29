//
//  ProductCellTest.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 27/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class ProductCellTest: XCTestCase {

    var cell: ProductCell?
    
    override func setUp() {
        super.setUp()
        cell = Bundle.main.loadNibNamed(ProductCell.identifier, owner: self, options: nil)?.first as? ProductCell
        XCTAssert(!cell!.subviews.isEmpty, "Cell subviewiews not loaded")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFill() {
        cell?.fill(with: Product(title: "Title", image: nil, price: 1, currency: nil, dimension: ""), viewModel: ProductListViewModel())
    }

    func testStepperChanged() {
        cell?.onAddButton(self)
    }
}
