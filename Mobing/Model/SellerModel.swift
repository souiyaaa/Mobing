//
//  SellerModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation

struct SellerModel: Identifiable, Hashable, Codable {
    var id = UUID()
    var username: String
    var email: String
    var password: String
    var listCar: [CarModel]
}
