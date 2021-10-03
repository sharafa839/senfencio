//
//  CartModel.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
struct Cart: Codable {
    let payload: CartPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct CartPayload: Codable {
    let id, userID, status: String?
    let customer: Bool?
    let products: [Products]?
}

// MARK: - Product
struct Products: Codable {
    let productID: String?
    let quantity: Int?
    let nameAr, name: String?
    let image: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case productID, quantity
        case nameAr = "name_ar"
        case name, image, price
    }
}
