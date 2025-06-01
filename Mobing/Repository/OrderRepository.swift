//
//  OrderRepository.swift
//  Mobing
//
//  Created by Daffa Khoirul on 01/06/25.
//

import Foundation
import FirebaseDatabase

class FireBaseOrderRepository {
    private let ref: DatabaseReference
    
    init() {
        self.ref = Database.database().reference().child("orders")
    }
    
    func createOrder(order: OrderModel, completion: @escaping (Error?) -> Void) {
        let orderDict: [String: Any] = [
            "id": order.id.uuidString,
            "userId": order.userId,
            "carId": order.carId,
            "sellerId": order.sellerId,
            "date": ISO8601DateFormatter().string(from: order.date),
            "totalPrice": order.totalPrice,
            "address": order.address,
            "phone": order.phone
        ]
        
        ref.child(order.id.uuidString).setValue(orderDict) { error, _ in
            completion(error)
        }
    }
}
