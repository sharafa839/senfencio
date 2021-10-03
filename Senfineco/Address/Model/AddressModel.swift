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
    let id: String?
    let address: Address?
}

// MARK: - Address
struct Address: Codable {
    let street1, street2, city, state: String?
    let country, notes: String?
    let zip : String?
}
