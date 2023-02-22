//
//  FullCardData.swift
//  StudHunter
//
//  Created by Антон Плотников on 23.08.2023.
//

import Foundation



struct FullCardData: Decodable{
    let publication: publication
    let user: user
    let userIsOwner: Bool
}
struct publication: Decodable{
    let id: String
    let imageUrl: String
    let title: String
    let description: String
    let price: Int?
    let priceType: String
    let district: String
    let timestamp: Double
    let category: String
    let userId: String
    let socials: String
    //let approved: JSONNull
}
struct user: Decodable{
    let id: String
    let username: String
    let rating: Double
    let name: String
    let surname: String
    let email: String
    let university: String
}
    

    
    
    
    
    
    
    
    
    
//
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case imageURL = "imageUrl"
//        case title, description, price, priceType, district, timestamp, category
//        case userID = "userId"
//        case socials//, approved
//    }
//   //static let sampleData: JSData = Requesting().dataBase[0]
