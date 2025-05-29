//
//  DetailCarView.swift
//  Mobing
//
//  Created by Daffa Khoirul on 29/05/25.
//

import SwiftUI

import SwiftUI

struct DetailCarView: View {
    let car: CarModel
    
    var body: some View {
        ScrollView {
            Text("\(car.yearBuilt)")
            VStack(alignment: .leading, spacing: 16) {
                // Header Image
                AsyncImage(url: URL(string: car.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 250)
                }
                
                // Basic Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(car.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(car.brand)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("$\(car.price, specifier: "%.2f")")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(6)
                        
                        if car.insentive > 0 {
                            Text("Save $\(car.insentive, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.green)
                                .cornerRadius(6)
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Specifications
                VStack(alignment: .leading, spacing: 12) {
                    Text("Specifications")
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack {
                        Image(systemName: "calendar")
                            .frame(width: 30)
                            .foregroundColor(.blue)
                        
                        Text("Year")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        // Pastikan menggunakan ini (tanpa specifier):
                        Text("\(car.yearBuilt)")  // Ini akan menampilkan 2023
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Image(systemName: "speedometer")
                            .frame(width: 30)
                            .foregroundColor(.blue)
                        
                        Text("Distance")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(car.totalDistance, specifier: "%.0f")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Image(systemName: "person")
                            .frame(width: 30)
                            .foregroundColor(.blue)
                        
                        Text("seller ID")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("\(car.sellerId)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                }
                .padding(.horizontal)
                
                Divider()
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(car.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // Contact Button
                VStack(spacing: 16) {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Contact Seller")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .padding(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}





#Preview {
    NavigationStack {
        DetailCarView(car: CarModel(
            name: "Model S Plaid",
            brand: "Tesla",
            price: 89999,
            totalDistance: 12000,
            yearBuilt: 2023,
            insentive: 2500,
            imageUrl: "https://example.com/tesla.jpg",
            description: "The Tesla Model S Plaid is the highest-performance version of Tesla's flagship sedan. It features a tri-motor setup producing 1,020 horsepower, enabling a 0-60 mph time of just 1.99 seconds. With an EPA-estimated range of 396 miles, it combines blistering acceleration with long-distance capability. The interior features a 17-inch touchscreen, yoke steering wheel, and premium materials throughout.",
            sellerId: 12345
        ))
    }
}

