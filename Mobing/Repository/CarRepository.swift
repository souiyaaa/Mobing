//
//  CarRepository.swift
//  Mobing
//
//  Created by Daffa Khoirul on 29/05/25.
//

import Foundation

import Foundation
import FirebaseDatabase

class FireBaseCarRepository {
    private let ref: DatabaseReference
    
    init() {
        self.ref = Database.database().reference().child("cars")
    }
    
    
    func fetchCars(for userID: String, completion: @escaping ([CarModel]) -> Void) {
        ref.observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
            guard let value = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            let fetchedCars: [CarModel] = value.compactMap { (_, carData) in
                guard let carsDict = carData as? [String: Any],
                      let jsonData = try? JSONSerialization.data(withJSONObject: carsDict),
                      let cars = try? JSONDecoder().decode(CarModel.self, from: jsonData)
                else {
                    return nil
                }
                return cars
            }
            
            let sorted = fetchedCars.sorted { $0.yearBuilt > $1.yearBuilt }
            completion(sorted)
        })
    }
    func fetchCarById(for carID: Int, completion: @escaping (CarModel?) -> Void) {
        let carRef = ref.child(String(carID)) // karena key-nya angka, perlu diubah ke String
        
        carRef.observeSingleEvent(of: .value) { snapshot in
            guard let carData = snapshot.value as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: carData),
                  let car = try? JSONDecoder().decode(CarModel.self, from: jsonData) else {
                completion(nil)
                return
            }
            completion(car)
        }
    }
    
    
    
}

