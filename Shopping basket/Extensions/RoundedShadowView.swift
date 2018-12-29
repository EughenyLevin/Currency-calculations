//
//  RoundedShadowView.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func makeRoundedShadow() {
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
    }
}


