//
//  ProfileData.swift
//  StudHunter
//
//  Created by Антон Плотников on 11.08.2023.
//

import Foundation

struct ProfileData: Codable, Hashable {
    let id: String
    let username: String
    let rating: Double
    let name: String
    let surname: String
    let email: String
    let university: String
}
