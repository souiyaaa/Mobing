//
//  UserModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 23/05/25.
//

import Foundation

struct UserModel {
    var id: String = ""
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var currentUserSession: String = ""
    var listOrders: [OrderModel] = []
}
