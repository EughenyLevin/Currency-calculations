//
//  Product.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    let title: String
    let image: UIImage?
    var price: Double
    var currency: Currency?
    var dimension: String
}

extension Product: Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
