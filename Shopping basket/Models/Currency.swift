//
//  Currency.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let iso: String
    let description: String
    
    init(shortTitle: String, fullTitle: String) {
        iso = shortTitle
        description = fullTitle
    }
}
