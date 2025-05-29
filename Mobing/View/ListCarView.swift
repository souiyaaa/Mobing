//
//  ListCarView.swift
//  Mobing
//
//  Created by Daffa Khoirul on 29/05/25.
//

import SwiftUI

//  ListCarView.swift

import SwiftUI

struct ListCarView: View {
    let cars: [CarModel] = [
        CarModel(
            name: "Model S",
            brand: "Tesla",
            price: 79999,
            totalDistance: 15000,
            yearBuilt: 2022,
            insentive: 2000,
            imageUrl: "https://example.com/tesla.jpg",
            description: "Electric vehicle",
            sellerId: 1
        ),
        CarModel(
            name: "Camry",
            brand: "Toyota",
            price: 29999,
            totalDistance: 45000,
            yearBuilt: 2020,
            insentive: 0,
            imageUrl: "https://example.com/camry.jpg",
            description: "Sedan",
            sellerId: 2
        ),
        CarModel(
            name: "Mustang",
            brand: "Ford",
            price: 45999,
            totalDistance: 20000,
            yearBuilt: 2021,
            insentive: 1500,
            imageUrl: "https://example.com/mustang.jpg",
            description: "Sports car",
            sellerId: 3
        )
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(cars) { car in
                    CarCardView(car: car)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Available Cars")
    }
}

#Preview {
    NavigationStack {
        ListCarView()
    }
}
#Preview {
    ListCarView()
}
