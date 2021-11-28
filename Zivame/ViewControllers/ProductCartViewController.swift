//
//  ProductCartViewController.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import UIKit

class ProductCartViewController : UIViewController {
    
    @IBOutlet weak var listView : UITableView!
    
    var viewModel : ProductViewModel = ProductViewModel()

    var cart : [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        listView.tableFooterView = UIView()
        cart = viewModel.cartItems
        
        if cart.count <= 0 {
            let lbl = UILabel.init(frame: listView.frame)
            lbl.text = "Please add items in Cart"
            lbl.textAlignment = .center
            listView.tableHeaderView = lbl
        } else {
            listView.tableHeaderView?.removeFromSuperview()
            listView.tableHeaderView = nil
        }
        
    }
    
    @IBAction func checkout(_ sender: UIButton) {
        if cart.count > 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductLoadingViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    
    
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension ProductCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        cell?.wrap(cart[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteFromCart(cart[indexPath.row])
            cart = viewModel.cartItems
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

