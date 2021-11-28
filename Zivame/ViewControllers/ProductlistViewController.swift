//
//  ProductlistViewController.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import UIKit
//7050681236
class ProductlistViewController : UIViewController {
    
    @IBOutlet weak var listView : UITableView!
    
    var viewModel : ProductViewModel = ProductViewModel()
    
    var cart : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        listView.tableFooterView = UIView()
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.listView.reloadData()
                self?.cart = self?.viewModel.cartItems ?? []
            }
        }
        
        viewModel.getProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.cart = self.viewModel.cartItems
        self.listView.reloadData()
    }
    
}


// MARK:- UITableViewDelegate & UITableViewDataSource
extension ProductlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.wrap(viewModel.products[indexPath.row])
        if cart.contains(where: {$0.name == viewModel.products[indexPath.row].name}) {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        viewModel.addToCart(product)
        if !cart.contains(where: {$0.name == product.name}) {
            cart.append(product)
        }
    }
    
}
