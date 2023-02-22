//
//  MyPublicationsData.swift
//  StudHunter
//
//  Created by Антон Плотников on 24.08.2023.
//

import Foundation

struct MyPublicationsData:Codable,Identifiable, Hashable {
    let id: String
    let imageUrl: String
    let title: String
    let description: String
    let price: Int?
    let priceType: String
    let timestamp: Double
    let userId: String
    let approved: BooleanLiteralType?
    let views: Int64
    let favorites: Int64
    
}
