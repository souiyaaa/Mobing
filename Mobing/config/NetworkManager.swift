import Foundation
import Network

class NetworkManager: ObservableObject {
    @Published var isConnected = true // Default to true, will be updated quickly

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                if !self!.isConnected {
                    print("❌ No internet connection.")
                } else {
                    print("✅ Internet connection is available.")
                }
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
