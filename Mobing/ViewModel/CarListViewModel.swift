//
//  CarListViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation

@MainActor
class CarListViewModel: ObservableObject{
    @Published var cars: [CarModel] = []
    
    func fetchCars(){
        
    }
    
}
