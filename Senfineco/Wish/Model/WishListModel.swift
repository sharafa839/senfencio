//
//  WishListModel.swift
//  Senfineco
//
//  Created by ahmed on 9/12/21.
//

import Foundation
import RxDataSources
struct SectionModel {
    var header :String
    var items : [WishListPayload]
}
extension SectionModel : SectionModelType{
    init(original: SectionModel, items: [WishListPayload]) {
        self = original
        self.items = items
    }
    
    
}
struct WishList: Codable {
    let payload: [WishListPayload]?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct WishListPayload: Codable {
    let id, userID, productID: String?
    let price: Int?
    let curreny, nameAr, name: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, userID, productID, price, curreny
        case nameAr = "name_ar"
        case name, image
    }
}
