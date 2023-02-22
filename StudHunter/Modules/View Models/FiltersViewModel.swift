//
//  FiltersViewModel.swift
//  StudHunter
//
//  Created by Антон Плотников on 19.08.2023.
//

import Foundation
class FiltersViewModel:Decodable{
    let minPrice: Int?
    let maxPrice: Int?
    let minUserRating: Int?
    let priceTypes: [String]?
    let districs: [String]?
    let categories: [String]?
}

//class DataModel: ObservableObject {
//    @Published var someData: String = ""
//}
