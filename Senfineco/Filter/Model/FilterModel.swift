//
//  FilterModel.swift
//  Senfineco
//
//  Created by ahmed on 9/14/21.
//

import Foundation
import RxDataSources
struct FilterModel: Codable {
    let payload: FilterModelPayload?
    let code: Int?
    let status: Bool?
    let message: String?
}

// MARK: - Payload
struct FilterModelPayload: Codable {
    let make, type, model: [String]?

    enum CodingKeys: String, CodingKey {
        case make = "Make"
        case type
        case model = "Model"
    }
}
struct filterSection {
    var header:String
    var items : [String]
}
extension filterSection : SectionModelType{
    init(original: filterSection, items: [String]) {
        self = original
        self.items = items
    }
    
    
}
