//
//  ProductBasketViewModel.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

protocol ProductBasketView: class {
    func showError(error: ErrorModel)
    func updateSum(with multiplier: Double, iso: String)
}

class ProductBasketViewModel {
    
    private var basket = Set<Product>()
    private var currencyList = [Currency]()
    private var service = CurrencyService()
    weak var view: ProductBasketView?
    
    var currencyListCount: Int  {
        return currencyList.count
    }
    
    init(with view: ProductBasketView) {
        self.view = view
    }
    
    var allTitles: [String] {
        var titles = [String]()
        basket.forEach { (product) in
            titles.append(product.title)
        }
        return titles
    }
    
    var basketSum: Double {
        var sum = 0.0
        basket.forEach { (product) in
            sum += product.price
        }
        return sum
    }
    
    init(basket: Set<Product>) {
        self.basket = basket
    }
}

extension ProductBasketViewModel: BasketViewModelBehavior {
    func getCurrencies() {
        service.getCurrencyList {[weak self] (list, error) in
            DispatchQueue.main.async {
                if let _error = error {
                    self?.view?.showError(error: _error)
                    return
                }
                if let currencies = list {
                    self?.currencyList =  currencies.sorted(by: { $0.iso < $1.iso })
                }
            }
        }
    }
    
    func currencyAt(row: Int) -> Currency {
        return currencyList[row]
    }
    
    func currencySelected(at index: Int) {
        let selectedCurrency = currencyList[index]
        let baseCurrency = Currency(shortTitle: "USD", fullTitle: "")
        service.convertCurrency(from: baseCurrency.iso, to: selectedCurrency.iso) {[weak self] (multiplier, error) in
            DispatchQueue.main.async {
                if let _error = error {
                    self?.view?.showError(error: _error)
                    return
                }
                if let _multiplier = multiplier {
                    self?.view?.updateSum(with: _multiplier, iso: selectedCurrency.iso)
                }
            }
        }
    }
}
