//
//  OrderViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation


@MainActor
class OrderViewModel: ObservableObject{
    
    @Published var orders: [OrderModel] = []
    @Published var selecetedOrderHistory: OrderModel?
    
    init(orders: [OrderModel], selecetedOrderHistory: OrderModel? = nil) {
        self.orders = orders
        self.selecetedOrderHistory = selecetedOrderHistory
    }
    
    func createOrder(carId: Int, name: String, address: String, phone: String, date: Date) {
        
    }
    
    func fetchAll(userId: Int){
        
    }
    
    func getOrderDetail(orderId: Int){
        
    }
    
}
