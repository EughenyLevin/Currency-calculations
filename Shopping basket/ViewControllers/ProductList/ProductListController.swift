//
//  ViewController.swift
//  Shopping basket
//
//  Created by Evgeniy on 24/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

protocol ProductListViewModelBehavior: class {
    var view: ProductListView? {set get}
    func createProducts()
    func addOrRemoveProduct(_ product: Product, handler: productSelectionHandler)
    func showBasket(handler: productBasketHandler)
}

class ProductListController: UIViewController {

    private var viewModel: ProductListViewModelBehavior!
    private var products = [Product]()
    private var router: ProductListRouting!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        configureViewModel()
        configureRouter()
    }
    
    private func UISetup() {
        let cellNib = UINib(nibName: ProductCell.identifier, bundle: Bundle.main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        collectionView.dataSource   = self
        collectionView.delegate     = self
        let basketImage = UIImage(named: "basket")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: basketImage, style: .plain, target: self, action: #selector(onBasket))
    }
    
    private func configureViewModel() {
        viewModel = ProductListViewModel()
        viewModel.view = self
        viewModel.createProducts()
    }
    
    private func configureRouter() {
        router = ProductListRouter()
    }
    
    @objc private func onBasket() {
        viewModel.showBasket {[unowned self] (basket, error) in
            if let _error = error {
                self.router.perform(segue: .error(_error), from: self)
                return
            }
            if let productBasket = basket {
                self.router.perform(segue: .basket(productBasket), from: self)
            }
        }
    }
}

//MARK: UICollectionViewDataSource
extension ProductListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.fill(with: products[indexPath.row], viewModel: viewModel)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension ProductListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.maxX - 20,
                      height: collectionView.bounds.height / 1.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ProductListController: ProductListView {
    
    func showProducts(products: [Product]) {
        self.products = products
        collectionView.reloadData()
    }
    
    func showError(error: ErrorModel) {
        router.perform(segue: .error(error), from: self)
    }
}
