//
//  CarListViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 26/05/25.
//

import Foundation
import Combine
import Network // Import Network framework untuk NWPathMonitor status codes

@MainActor
class CarListViewModel: ObservableObject {
    @Published var cars: [CarModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isShowingNoInternetMessage: Bool = false

    private let repository = FireBaseCarRepository()
    private var networkManager: NetworkManager
    private var cancellables = Set<AnyCancellable>()

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        setupBindings()
    }

    private func setupBindings() {
        networkManager.$isConnected
            .sink { [weak self] isConnected in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    print("NetworkManager status change detected: isConnected = \(isConnected)")

                    if !isConnected {
                        self.isShowingNoInternetMessage = true
                        self.errorMessage = "Tidak ada koneksi internet."
                        print("❌ Koneksi terputus. Menampilkan pesan 'No internet'.")
                    

                    } else {
                        print("✅ Koneksi terdeteksi kembali. Menghilangkan pesan 'No internet'.")
                        self.isShowingNoInternetMessage = false
                        self.errorMessage = nil

                        if self.cars.isEmpty { // Tidak perlu !self.isLoading di sini, karena fetchCars() akan menangani itu
                            print("🚗 Daftar mobil kosong. Memulai fetch ulang secara otomatis.")
                            Task { await self.fetchCars() }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }

    func fetchCars() async {
        if isLoading {
            print("⏳ Sudah dalam proses loading, fetch diabaikan.")
            return
        }

        if !networkManager.isConnected {
            self.errorMessage = "Tidak ada koneksi internet."
            self.isShowingNoInternetMessage = true
            self.isLoading = false
            print("❌ Tidak ada koneksi internet. Menghentikan fetch.")
            return
        }

        self.isLoading = true
        self.errorMessage = nil
        self.isShowingNoInternetMessage = false

        print("🚀 Memulai proses fetch mobil...")
        do {
            let fetchedCars = try await repository.fetchCars()
            self.cars = fetchedCars

            if fetchedCars.isEmpty {
                self.errorMessage = "Tidak ada mobil yang ditemukan."
                print("⚠️ Fetch berhasil, tetapi tidak ada mobil ditemukan.")
            } else {
                self.errorMessage = nil
                print("👍 Fetch berhasil. Jumlah mobil: \(fetchedCars.count)")
            }
        } catch {
            print("💔 Error saat fetch mobil: \(error.localizedDescription)")
            self.errorMessage = "Gagal memuat mobil: \(error.localizedDescription)"
            self.cars = [] // Kosongkan daftar mobil jika ada error

            // Perbaikan di sini: Gunakan nilai integer -1009 secara langsung
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain && nsError.code == -1009 { // NSURLErrorNotConnectedToInternet.rawValue
                self.isShowingNoInternetMessage = true
                self.errorMessage = "Tidak ada koneksi internet."
                print("❌ Error jaringan terdeteksi saat fetch.")
            } else if !networkManager.isConnected {
                self.isShowingNoInternetMessage = true
                self.errorMessage = "Tidak ada koneksi internet."
                print("❌ NetworkManager juga melaporkan offline saat error fetch.")
            } else {
                self.isShowingNoInternetMessage = false
                print("⚠️ Error fetch bukan karena jaringan.")
            }
        }
        self.isLoading = false
        print("🏁 Proses fetch mobil selesai.")
    }
}
