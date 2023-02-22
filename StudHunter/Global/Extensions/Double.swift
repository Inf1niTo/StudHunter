//
//  Double.swift
//  StudHunter
//
//  Created by Антон Сетямин on 19.02.2023.
//

import Foundation

extension Double{
    func twoDecimaPlaces() -> String{
        return String(format: "%.2f", self)
    }
}
