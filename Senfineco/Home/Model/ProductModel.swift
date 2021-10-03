//
//  ProductModel.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation
struct Product: Codable {
    let payload: [ProductPayload]?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct ProductPayload: Codable {
    let id, title, titleAr: String?
    let price, discount: Int?
    let sale, startSaleDateTime, endSaleDateTime, currency: String?
    let descriptionEn, descriptionAr, shortDescriptionEn, shortDescriptionAr: String?
    let sku: String?
    let qty: Int?
    let howToUseEn, howToUseAr: String?
    let youtubeLink: String?
    let image: String?
    let gallery: [String]?
    let category, brand: String?
    let rate: Int?
    let productUnit: String?
    let group: GroupClass?
    let wholesaler: WholesalerP?

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleAr = "title_ar"
        case price, discount, sale, startSaleDateTime, endSaleDateTime, currency
        case descriptionEn = "description_en"
        case descriptionAr = "description_ar"
        case shortDescriptionEn = "short_description_en"
        case shortDescriptionAr = "short_description_ar"
        case sku, qty
        case howToUseEn = "how_to_use_en"
        case howToUseAr = "how_to_use_ar"
        case youtubeLink = "youtube_link"
        case image, gallery, category, brand, rate
        case productUnit = "product_unit"
        case group, wholesaler
    }
}

// MARK: - GroupClass
struct GroupClass: Codable {
    let priceGroup1, priceGroup2, priceGroup3, priceGroup4: Int?
    let priceGroup5, priceGroup6: Int?

    enum CodingKeys: String, CodingKey {
        case priceGroup1 = "price_group_1"
        case priceGroup2 = "price_group_2"
        case priceGroup3 = "price_group_3"
        case priceGroup4 = "price_group_4"
        case priceGroup5 = "price_group_5"
        case priceGroup6 = "price_group_6"
    }
}

// MARK: - Wholesaler
struct WholesalerP: Codable {
    let group: [String]?
    let productUnit: String?
    let itemsPerUnit, unitQty: Int?

    enum CodingKeys: String, CodingKey {
        case group
        case productUnit = "product_unit"
        case itemsPerUnit = "items_per_unit"
        case unitQty = "unit_qty"
    }
}
