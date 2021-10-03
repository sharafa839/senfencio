//
//  CategoryModel.swift
//  Senfineco
//
//  Created by ahmed on 9/7/21.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let payload: [CategoryPayload]?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct CategoryPayload: Codable {
    let id, categoryNameEn, categoryNameAr: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryNameEn = "category_name_en"
        case categoryNameAr = "category_name_ar"
        case image
    }
}
