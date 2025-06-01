//
//  OrderViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation


@MainActor
class OrderViewModel: ObservableObject {
    @Published var orders: [OrderModel] = []
    
    private let orderRepository: FireBaseOrderRepository
    private let networkManager: NetworkManager
    private let currentUserId = "999" // Simulasi user ID
    
    init(
        orderRepository: FireBaseOrderRepository = FireBaseOrderRepository(),
        networkManager: NetworkManager = NetworkManager()
    ) {
        self.orderRepository = orderRepository
        self.networkManager = networkManager
    }
    
    func createOrder(carId: Int, sellerId: Int, totalPrice: Double, address: String, phone: String, date: Date) {
        
        guard networkManager.isConnected else {
            print("❌ Tidak bisa membuat order. Tidak ada koneksi internet.")
            return
        }
        
        let newOrder = OrderModel(
            id: UUID(),
            userId: currentUserId,
            carId: carId,
            sellerId: sellerId,
            date: date,
            totalPrice: totalPrice,
            address: address,
            phone: phone
        )
        
        orderRepository.createOrder(order: newOrder) { error in
            if let error = error {
                print("Failed to create order: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.orders.append(newOrder)
                    print("✅ Order berhasil disimpan ke Firebase.")
                }
            }
        }
    }
}

