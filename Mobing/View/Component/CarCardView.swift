//
//  CarCardView.swift
//  Mobing
//
//  Created by Daffa Khoirul on 23/05/25.
//


import SwiftUI

struct CarCardView: View {
    let car: CarModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Car Image
            AsyncImage(url: URL(string: car.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()
            } placeholder: {
                Color.gray
                    .frame(height: 150)
            }
            .cornerRadius(8)
            
            // Car Details
            VStack(alignment: .leading, spacing: 4) {
                Text(car.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(car.brand)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text("\(car.yearBuilt)")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("\(car.totalDistance, specifier: "%.1f") km")
                        .font(.caption)
                }
                
                HStack {
                    Text("$\(car.price, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    if car.insentive > 0 {
                        Text("Save $\(car.insentive, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

#Preview {
    CarCardView(car: CarModel(
        name: "Model S",
        brand: "Tesla",
        price: 79999,
        totalDistance: 15000,
        yearBuilt: 2022,
        insentive: 2000,
        imageUrl: "https://example.com/tesla.jpg",
        description: "Electric vehicle",
        sellerId: 1
    ))
    .padding()
}
