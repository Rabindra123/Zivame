//
//  ProductCheckoutViewController.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import UIKit

class ProductCheckoutViewController : UIViewController {
    
    var viewModel : ProductViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.emptyCart()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction func continueShopping(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}
