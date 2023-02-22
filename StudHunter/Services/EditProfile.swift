//
//  EditProfile.swift
//  StudHunter
//
//  Created by Антон Плотников on 06.09.2023.
//

import Foundation

struct EditProfileRequest: Codable {
    let name: String
    let surname: String
    let university: String
}

struct ChangePubFavoriteStatusRequest: Codable {
    var publicationId: String
}
