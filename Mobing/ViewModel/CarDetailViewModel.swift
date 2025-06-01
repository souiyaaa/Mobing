//
//  CarDetailViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation
import FirebaseDatabase

@MainActor
class CarDetailViewModel: ObservableObject {
    @Published var car: CarModel?
    
    private var ref: DatabaseReference

    init(ref: DatabaseReference = Database.database().reference().child("cars")) {
        self.ref = ref
    }
    
    func fetchCarById(carId: Int) {
        let carRef = ref.child(String(carId)) // karena key-nya angka, convert ke String
        carRef.observeSingleEvent(of: .value) { snapshot in
            guard let carData = snapshot.value as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: carData),
                  let car = try? JSONDecoder().decode(CarModel.self, from: jsonData) else {
                print("❌ Gagal decode car id \(carId)")
                return
            }
            self.car = car
        }
    }
}
