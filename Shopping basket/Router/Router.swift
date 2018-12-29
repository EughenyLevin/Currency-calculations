//
//  Router.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation
import UIKit

enum SegueType {
    case basket(Set<Product>)
    case error(ErrorModel)
}

protocol ProductListRouting: class {
    func perform(segue: SegueType, from vc: UIViewController)
}

class ProductListRouter {
    
}

extension ProductListRouter: ProductListRouting {
    func perform(segue: SegueType, from vc: UIViewController) {
        switch segue {
        case .basket(let basket):
            let basketViewModel = ProductBasketViewModel(basket: basket)
            let basketVC = BasketViewController(with: basketViewModel, router: self)
            vc.navigationController?.pushViewController(basketVC, animated: true)
        case .error(let error):
            let alertVC = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            vc.present(alertVC, animated: true, completion: nil)
        }
    }
}
