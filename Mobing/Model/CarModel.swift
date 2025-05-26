//
//  CarModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation

struct CarModel: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var brand: String
    var price: Double
    var totalDistance: Double
    var yearBuilt: Int
    var insentive: Double
    var imageUrl: String
    var description: String
    var sellerId: Int
}
