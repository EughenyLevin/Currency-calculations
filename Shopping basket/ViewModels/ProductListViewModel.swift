//
//  ProductListViewModel.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation
import UIKit

typealias productSelectionHandler = (Bool)->()
typealias productBasketHandler = (Set<Product>?, ErrorModel?)->()

protocol ProductListView: class {
    func showProducts(products: [Product])
    func showError(error: ErrorModel)
}

class ProductListViewModel{
    
    private var products = Array<Product>()
    private var basket   = Set<Product>()
    weak var view: ProductListView?
    
    var productCount: Int {
        return products.count
    }
    
    func findProduct(_ product: Product) -> [Product] {
        return basket.filter { (currentProduct) -> Bool in
            if currentProduct.title == product.title {
                return true
            }
            return false
        }
    }
}

extension ProductListViewModel: ProductListViewModelBehavior {
    
    func showBasket(handler: productBasketHandler) {
        guard !basket.isEmpty else {
            handler(nil, ErrorModel(title: "Attention", message: "No products in your basket"))
            return
        }
        handler(basket, nil)
    }
   
    func addOrRemoveProduct(_ product: Product,  handler: productSelectionHandler) {
        guard basket.contains(product) else {
            basket.insert(product)
            handler(true)
            return
        }
        if let currentProduct = findProduct(product).first {
            basket.remove(currentProduct)
            handler(false)
        }
    }
    
    func createProducts() {
        products = [Product(title: "Peas",
                                image: UIImage(named: "peas"),
                                price: 0.95,
                                currency: nil,
                                dimension: "bag"),
                        Product(title: "Eggs",
                                image: UIImage(named: "eggs"),
                                price: 2.10,
                                currency: nil,
                                dimension: "dozen"),
                        Product(title: "Milk",
                                image: UIImage(named: "milk"),
                                price: 1.30,
                                currency: nil,
                                dimension: "bottle"),
                        Product(title: "Beans",
                                image: UIImage(named: "beans"),
                                price: 0.73,
                                currency: nil,
                                dimension:"can")]
        view?.showProducts(products: products)
    }
}
