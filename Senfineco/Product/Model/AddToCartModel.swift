//
//  AddToCartModel.swift
//  Senfineco
//
//  Created by ahmed on 9/8/21.
//

import Foundation
struct AddToCart: Codable {
    let error: String?
    let code: Int?
    let status: Bool?
    let message: String?
    let payload: Bool?
}
