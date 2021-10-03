//
//  ProfileModel.swift
//  Senfineco
//
//  Created by ahmed on 9/13/21.
//

import Foundation
struct ProfileData: Codable {
    let id, fname, lname, email: String
    let role, phone, group: String
}
