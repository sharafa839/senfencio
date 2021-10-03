//
//  AddressModel.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
struct AddressModel: Codable {
    let payload: [AddressModelPayload]?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct AddressModelPayload: Codable {
    var id: String?
    var address: Address?
}

// MARK: - Address
struct Address: Codable {
    var street1, street2, city, state: String?
    var country, notes: String?
    var zip : String?
}
struct MakeNewOrder: Codable {
    let payload: MakeNewOrderPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct MakeNewOrderPayload: Codable {
    let id, customerID, paymentID: String?
    let user: User?
    let date, paymentStatus, status, currency: String?
    let totalCost: Int?
    let items: [Item]?
    let shipping: Shipping?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customerId"
        case paymentID = "paymentId"
        case user, date, paymentStatus, status, currency, totalCost, items, shipping
    }
}

// MARK: - Item
struct Item: Codable {
    let sku, title, productID: String?
    let quantity, discount, tax, total: Int?
    let price: Int?
}

// MARK: - Shipping
struct Shipping: Codable {
    let address: Address?
    let phone, userID: String?
}

// MARK: - Address
/*struct Address: Codable {
    let street1, street2, city, state: String
    let country, zip, notes: String
}*/

// MARK: - User
struct User: Codable {
    let fname, lname, email, group: String?
    let phone: String?
}

