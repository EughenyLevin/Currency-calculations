//
//  ProductCell.swift
//  TestTask
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addButton: BuyButton!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    
    static let identifier = "ProductCell"
    
    private weak var viewModel: ProductListViewModelBehavior?
    private var currentProduct: Product?
    private var buttonWidth: (CGFloat, CGFloat) = (expand: 140, collapse: 90)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UISetup()
    }
    
    private func UISetup(){
        containerView.layer.cornerRadius  = 8
        containerView.layer.masksToBounds = true
        makeRoundedShadow()
        addButton.borderColor = UIColor.green
    }
    
    private func bounce(_ bounce: Bool) {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.8,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: { self.transform = bounce ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity },
            completion: nil)
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        bounce(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {[weak self] in
            self?.bounce(false)
        }
        
        guard let product = currentProduct else { return }
        viewModel?.addOrRemoveProduct(product, handler: {[weak self] (isAdded) in
            guard let _self = self else {return}
            _self.addButton.borderColor = isAdded ? UIColor.red : UIColor.green
            _self.addButton.setTitle(isAdded ? "Remove from list" : "Add to list", for: .normal)
            _self.buttonWidthConstraint.constant = isAdded ? _self.buttonWidth.0 : _self.buttonWidth.1
            UIView.animate(withDuration: 0.1, animations: {
                _self.layoutIfNeeded()
            })
        })
    }

    func fill(with product: Product, viewModel: ProductListViewModelBehavior) {
        self.viewModel = viewModel
        currentProduct = product
        productTitle.text = product.title
        productImage.image = product.image
        let stringPrice = String(product.price)
        if let currency = product.currency?.iso {
            productPrice.text = "\(stringPrice)\(currency) per \(product.dimension)"
        } else {
            productPrice.text = "\(stringPrice)USD  per \(product.dimension)"
        }
    }

    override func prepareForReuse() {
        productTitle.text = nil
        productPrice.text = nil
    }
}
