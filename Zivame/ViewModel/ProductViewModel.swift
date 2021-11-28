//
//  ProductViewModel.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import UIKit

class ProductViewModel : NSObject {
    
    private let networkManager : NetworkRequest = .init(.init())
    
    private let db : CoreDataWrapper = .init()
    
    var onSuccess: (() -> Void)?

    var cartItems : [Product] {
        return db.getCartItems()
    }
    
    var products: [Product] = [] {
        didSet {
            onSuccess?()
        }
    }
    
    override init() {
        super.init()
    }
    
    func getProductList() {
        networkManager.list(completion: { (result) in
            switch result {
            case .success(let products):
                self.products = products.products ?? []
            case .failure(_):
                self.products = []
            }
        })
    }
    
    func addToCart(_ product: Product) {
        db.add(product)
        onSuccess?()
    }
    
    func deleteFromCart(_ product: Product) {
        db.delete(product)
        onSuccess?()
    }
    
    func emptyCart() {
        db.emptyCart()
        onSuccess?()
    }
        
}
