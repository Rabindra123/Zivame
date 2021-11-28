//
//  ProductLoadingViewController.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import UIKit

class ProductLoadingViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ProductCheckoutViewController")
            if let viewController = vc {
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    
}
