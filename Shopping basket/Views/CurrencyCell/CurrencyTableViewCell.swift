//
//  CurrencyCellTableViewCell.swift
//  Shopping basket
//
//  Created by Evgeniy on 26/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    static let cellID = "CurrencyTableViewCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var isoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with currency: Currency)  {
        descriptionLabel.text = currency.description
        isoLabel.text = currency.iso
    }
    
}
