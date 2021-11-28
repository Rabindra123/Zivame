//
//  ProductModel.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation

// MARK: - ProductListModel
struct ProductListModel: Codable {
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let name, price: String?
    let imageURL: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, price
        case imageURL = "image_url"
        case rating
    }
}
