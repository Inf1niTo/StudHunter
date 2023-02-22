//
//  HomeModel.swift
//  StudHunter
//
//  Created by Антон Сетямин on 16.02.2023.
//

import Foundation

enum Brands: String{
    case brand1 = "Brand 1"
    case brand2 = "Brand 2"
    case brand3 = "Brand 3"
    case brand4 = "Brand 4"
    case brand5 = "Brand 5"
}


struct ProductModel: Identifiable{
    let id: String
    let image: String
    let name: String
    let article: String
    let brands: Brands
    let description: String
    let cost: Double
    let date: String
    let location: String
    
    init(id:String = UUID().uuidString, article: String, brands:Brands, name:String, description: String, image: String, cost:Double, date:String, location:String){
        self.id = id
        self.article = article
        self.brands = brands
        self.description = description
        self.cost = cost
        self.image = image
        self.name = name
        self.date = date
        self.location = location
    }
    
    var data: [String: Any]{
        var data: [String: Any] = [:]
        data["id"] = id
        data["article"] = article
        data["brands"] = brands
        data["descriprion"] = description
        data["cost"] = cost
        data["image"] = image
        data["name"] = name
        data["date"] = date
        data["location"] = location
        return data
    }
}
