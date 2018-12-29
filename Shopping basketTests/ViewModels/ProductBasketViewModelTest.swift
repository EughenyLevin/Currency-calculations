//
//  ProductBasketViewModelTest.swift
//  Shopping basketTests
//
//  Created by Evgeniy on 27/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import XCTest
@testable import Shopping_basket

class ProductBasketViewModelTest: XCTestCase {
    var viewModel: ProductBasketViewModel?
    let product1 = Product(title: "Peas", image: UIImage(named: "peas"), price: 0.95, currency: nil, dimension: "bag")
    let product2 = Product(title: "Eggs", image: UIImage(named: "eggs"), price: 2.10, currency: nil, dimension: "dozen")
    let product3 = Product(title: "Milk", image: UIImage(named: "milk"), price: 1.30, currency: nil, dimension: "bottle")
    let product4 = Product(title: "Beans", image: UIImage(named: "beans"), price: 0.73, currency: nil, dimension:"can")
    
    override func setUp() {
        var productBasket = Set<Product>()
        
        productBasket.insert(product1)
        productBasket.insert(product2)
        productBasket.insert(product3)
        productBasket.insert(product4)
        
        viewModel = ProductBasketViewModel(basket: productBasket)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTotalAmount() {
        XCTAssertEqual(viewModel?.basketSum, 5.08, "ProductBasketViewModel: totalAmount fail")
    }
    
    func testAddedTitles() {
        guard let basketViewModel = viewModel else {
            return
        }
        XCTAssertTrue(basketViewModel.allTitles.count > 0, "ProductBasketViewModel: titles array is empty")
    }
    
    func testCuurencyRate() {
       
    }
}
