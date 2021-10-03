//
//  MyOrderModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
import RxDataSources
struct OrdersModel {
    var section:String
    var items : [OrdersPayload]
}
extension OrdersModel :SectionModelType{
    init(original: OrdersModel, items: [OrdersPayload]) {
        self = original
        self.items = items
    }
    
    
}
// MARK: - Orders
struct Orders: Codable {
    let payload: [OrdersPayload]?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct OrdersPayload: Codable {
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
struct TrackOrder: Codable {
    let payload: TrackOrderPayload
    let code: Int
    let status: Bool
    let message: String
}

// MARK: - Payload
struct TrackOrderPayload: Codable {
    let status, payment: String?
}


// MARK: - Item
/*struct Item: Codable {
    let sku, title, productID: String
    let quantity, discount, tax, total: Int
    let price: Int
}
*/
// MARK: - Shipping
/*struct Shipping: Codable {
    let address: Address
    let phone, userID: String
}
*/
// MARK: - Address
/*struct Address: Codable {
    let street1, street2, city, state: String
    let country, zip, notes: String
}
*/
// MARK: - User
/*struct User: Codable {
    let fname, lname, email, group: String
    let phone: String
}
*/
