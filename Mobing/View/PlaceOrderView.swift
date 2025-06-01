//
//  PlaceOrderView.swift
//  Mobing
//
//  Created by Daffa Khoirul on 31/05/25.
//

import SwiftUI

import SwiftUI

struct PlaceOrderView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: OrderViewModel = OrderViewModel()
    let car: CarModel

    @State private var address: String = ""
    @State private var phone: String = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Order Details").foregroundColor(.cyan)) {
                    HStack {
                        Text("Car:")
                        Spacer()
                        Text("\(car.brand) \(car.name)")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Price:")
                        Spacer()
                        Text("$\(car.price, specifier: "%.2f")")
                            .foregroundColor(.gray)
                    }
                    
                    if car.insentive > 0 {
                        HStack {
                            Text("Discount:")
                            Spacer()
                            Text("-$\(car.insentive, specifier: "%.2f")")
                                .foregroundColor(.green)
                        }
                        
                        HStack {
                            Text("Total:")
                            Spacer()
                            Text("$\(car.price - car.insentive, specifier: "%.2f")")
                                .fontWeight(.bold)
                        }
                    }
                }
                
                Section(header: Text("Delivery Information").foregroundColor(.cyan)) {
                    TextField("Delivery Address", text: $address)
                        .foregroundColor(.white)
                    
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                        .foregroundColor(.white)
                }
                
                Section {
                    Button(action: {
                        viewModel.createOrder(
                            carId: car.id,
                            sellerId: car.sellerID,
                            totalPrice: car.price - car.insentive,
                            address: address,
                            phone: phone,
                            date: Date()
                        )
                        showingConfirmation = true
                    }) {
                        HStack {
                            Spacer()
                            Text("Confirm Order")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .disabled(address.isEmpty || phone.isEmpty)
                }
            }
            .navigationTitle("Place Order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Order Placed", isPresented: $showingConfirmation) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your order for \(car.brand) \(car.name) has been placed successfully!")
            }
            .background(Color.black)
            .scrollContentBackground(.hidden)
        }
        .tint(.cyan)
    }
}

#Preview {
    PlaceOrderView(
        car : CarModel(
            id: 1,
            name: "Model 3",
            brand: "Tesla",
            price: 35000,
            totalDistance: 2000,
            yearBuilt: 2020,
            insentive: 2500,
            imageURL: "https://www.tesla.com/sites/default/files/styles/large/public/model3-front-quarter-1200.jpg?itok=1547477684",
            description: "This is a description",
            sellerID: 1,
            isSold: false
        )
    )
}


#Preview {
    PlaceOrderView(
        car : CarModel(
            id: 1,
            name: "Model 3",
            brand: "Tesla",
            price: 35000,
            totalDistance: 2000,
            yearBuilt: 2020,
            insentive: 2500,
            imageURL: "https://www.tesla.com/sites/default/files/styles/large/public/model3-front-quarter-1200.jpg?itok=1547477684",
            description: "This is a description",
            sellerID: 1,
            isSold: false
        )
    )
}

