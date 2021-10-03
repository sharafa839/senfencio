//
//  RegisterClientModel.swift
//  Senfineco
//
//  Created by ahmed on 9/6/21.
//

import Foundation

// MARK: - RegisterClientModel
struct RegisterClientModel: Codable {
    let payload: RegisterClientModelPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct RegisterClientModelPayload: Codable {
    let id, fname, lname, email: String?
    let phone, group: String?
    let wholesaler: Wholesaler?

}
struct Wholesaler: Codable {
    let company, crn: String

    enum CodingKeys: String, CodingKey {
        case company
        case crn = "CRN"
    }
}
