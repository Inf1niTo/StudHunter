//
//  JSData.swift
//  StudHunter
//
//  Created by Антон Плотников on 02.06.2023.
//

import Foundation
struct JSData:Codable,Identifiable {
    let id: String
    let imageURL: String
    let title: String
    let description: String
    let price: Int?
    let priceType: String
    let district: String
    let timestamp: Double
    let category: String
    let userID: String//
    let socials: String
    //let approved: JSONNull//
    
    

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title, description, price, priceType, district, timestamp, category
        case userID = "userId"
        case socials//, approved
    }
    static let sampleData: JSData = Requesting().dataBase[0]
}
// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
