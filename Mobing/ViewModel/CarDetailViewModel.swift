//
//  CarDetailViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation

@MainActor
class CarDetailViewModel: ObservableObject{
    @Published var car: CarModel?
    
    func fetchCarByCarId(carId: Int){
        
    }
    
}
