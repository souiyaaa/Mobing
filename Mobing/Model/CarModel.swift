//
//  CarModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation

struct CarModel: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
    var brand: String
    var price: Double
    var totalDistance: Double
    var yearBuilt: Int
    var insentive: Double
    var imageURL: String
    var description: String
    var sellerID: Int
    var isSold : Bool = false
}

