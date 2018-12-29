//
//  BasketViewController.swift
//  Shopping basket
//
//  Created by Evgeniy on 25/12/2018.
//  Copyright © 2018 Evgeniy. All rights reserved.
//

import UIKit

protocol BasketViewModelBehavior {
    var view: ProductBasketView? {set get}
    var currencyListCount: Int  { get }
    var allTitles: [String] { get }
    var basketSum: Double    { get }
    func getCurrencies()
    func currencyAt(row: Int)  -> Currency
    func currencySelected(at index: Int)
}

class BasketViewController: UIViewController {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var titlesLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var changeCurrencyButton: BuyButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    private var viewModel:   BasketViewModelBehavior!
    private weak var router: ProductListRouting?
    
    convenience init(with viewModel: BasketViewModelBehavior, router: ProductListRouting) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.view = self
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCurrencies()
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailsViewSetup()
    }
    
    private func tableViewSetup() {
        let cellNib = UINib(nibName: CurrencyTableViewCell.cellID, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: CurrencyTableViewCell.cellID)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func detailsViewSetup() {
        detailsView.makeRoundedShadow()
        let titles = viewModel.allTitles
        for title in titles {
            titlesLabel.text?.append("\n\(title)")
        }
        let sum = viewModel.basketSum
        sumLabel.text = String(format: "%.02f USD", sum)
    }
    
    //MARK: Actions
    
    @IBAction func onChangeCurrency(_ sender: Any) {
        guard viewModel.currencyListCount != 0 else {
            return
        }
        tableHeightConstraint.constant = 400
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.view.layoutIfNeeded()
        }
        tableView.reloadData()
    }
    @IBAction func onPay(_ sender: Any) { }
}

extension BasketViewController: ProductBasketView {
    func updateSum(with multiplier: Double, iso: String) {
        let sum = viewModel.basketSum * multiplier
        sumLabel.text = String(format: "%.02f %@", sum, iso)
    }

    func showError(error: ErrorModel) {
        router?.perform(segue: .error(error), from: self)
    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellID, for: indexPath) as? CurrencyTableViewCell {
            cell.fill(with: viewModel.currencyAt(row: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
}

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.currencySelected(at: indexPath.row)
        tableHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
