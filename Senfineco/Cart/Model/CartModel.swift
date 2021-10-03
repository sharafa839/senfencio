//
//  CartModel.swift
//  Senfineco
//
//  Created by ahmed on 9/9/21.
//

import Foundation
import RxDataSources

struct Cart: Codable {
    let payload: CartPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}
struct sectionCart {
    var items : [Products]
    var heades: String
    
}
extension sectionCart : SectionModelType{
    init(original: sectionCart, items: [Products]) {
        self = original
        self.items = items
    }
    
    
}
// MARK: - Payload
struct CartPayload: Codable {
    let id, userID, status: String?
    let customer: Bool?
    var products: [Products]?
}

// MARK: - Product
struct Products: Codable {
    let productID: String?
    var quantity: Int?
    let nameAr, name: String?
    let image: String?
    let price: Int?
    let total :Int?
    enum CodingKeys: String, CodingKey {
        case productID, quantity
        case nameAr = "name_ar"
        case name, image, price,total
    }
}
