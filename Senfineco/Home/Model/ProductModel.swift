//
//  ProductModel.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
import  RxDataSources
struct productsSection {
    let headers : String
    var items : [ProductPayload]
}
extension productsSection : SectionModelType {
    init(original: productsSection, items: [ProductPayload]) {
        self = original
        self.items = items
    }
    
    
}
struct Product: Codable {
    let status: Bool?
    let message: String?
    let payload: [ProductPayload]?
    let code: Int?
}

// MARK: - Payload
struct ProductPayload: Codable {
    let brand, howToUseEn, youtubeLink, descriptionAr: String?
    let endSaleDateTime, id, productUnit, descriptionEn: String?
    let shortDescriptionAr, startSaleDateTime, howToUseAr: String?
    let wholesaler: Wholesalerr?
    let gallery: [String]?
    let shortDescriptionEn, title: String?
    let qty: Int?
    let image: String?
    let discount: Int?
    let sku, sale: String?
    let group: Group?
    let titleAr: String?
    let rate, price: Int?
    let currency, category: String?

    enum CodingKeys: String, CodingKey {
        case brand
        case howToUseEn = "how_to_use_en"
        case youtubeLink = "youtube_link"
        case descriptionAr = "description_ar"
        case endSaleDateTime, id
        case productUnit = "product_unit"
        case descriptionEn = "description_en"
        case shortDescriptionAr = "short_description_ar"
        case startSaleDateTime
        case howToUseAr = "how_to_use_ar"
        case wholesaler, gallery
        case shortDescriptionEn = "short_description_en"
        case title, qty, image, discount, sku, sale, group
        case titleAr = "title_ar"
        case rate, price, currency, category
    }
}

// MARK: - Group
struct Group: Codable {
    let priceGroup4, priceGroup3, priceGroup2, priceGroup1: String?
    let priceGroup5, priceGroup6: String?

    enum CodingKeys: String, CodingKey {
        case priceGroup4 = "price_group_4"
        case priceGroup3 = "price_group_3"
        case priceGroup2 = "price_group_2"
        case priceGroup1 = "price_group_1"
        case priceGroup5 = "price_group_5"
        case priceGroup6 = "price_group_6"
    }
}

// MARK: - Wholesaler
struct Wholesalerr: Codable {
    let itemsPerUnit: String?
    let unitQty: UnitQty?
    let productUnit: String?
    let group: [String]?

    enum CodingKeys: String, CodingKey {
        case itemsPerUnit = "items_per_unit"
        case unitQty = "unit_qty"
        case productUnit = "product_unit"
        case group
    }
}

enum UnitQty: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(UnitQty.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnitQty"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
