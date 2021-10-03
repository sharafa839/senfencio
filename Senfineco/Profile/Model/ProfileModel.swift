//
//  ProfileModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
struct ProfileData: Codable {
    let id, fname, lname, email: String?
    let role, phone, group: String?
}
struct UpdateProfile: Codable {
    let message: String?
    let code: Int?
    let payload: UpdateProfilePayload?
    let status: Bool?
}

// MARK: - Payload
struct UpdateProfilePayload: Codable {
    let role: String?
    let wholesaler: Wholesaler?
    let id: String?
    let fname: String?
    let email: String
    let lname: String?
    let phone, group: String?
}

// MARK: - Wholesaler
