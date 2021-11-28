//
//  File.swift
//  ZivameTests
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import XCTest
@testable import Zivame

class ProductViewModelTest: XCTestCase {

    var product : [Product] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testViewModel() {
        let model = ProductViewModel()
        model.getProductList()
    }
    
    
    func testNetworkLogging() {
        let network = Network.init()
        let networkRequest = NetworkRequest.init(network)
        networkRequest.list { (result) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    XCTAssertTrue(model.products != nil)
                    XCTAssertTrue((model.products ?? []).count > 0)
                    self.product = model.products ?? []
                }
            case .failure(_):
                DispatchQueue.main.async {
                    XCTAssertFalse(self.product.count > 0)
                }
            }
        }
    }
    
}
