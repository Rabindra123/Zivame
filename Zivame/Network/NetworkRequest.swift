//
//  NetworkRequest.swift
//  ShoppingList
//
//  Created by Rabi on 28/11/21.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

class NetworkRequest {

    var network : Network?
    
    init(_ network: Network) {
        self.network = network
    }
    
    func list(completion: @escaping (Result<ProductListModel, Error>) -> Void) {
        self.network?.getJSON(url: Constants.URL.productList, handler: completion)
    }
}
