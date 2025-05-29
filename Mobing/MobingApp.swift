//
//  MobingApp.swift
//  Mobing
//
//  Created by Daffa Khoirul on 23/05/25.
//

import SwiftUI
import Firebase
import FirebaseAppCheck

@main
struct MobingApp: App {
    
     @StateObject private var authViewModel = AuthViewModel(repository: FirebaseAuthRepository())
     
     init(){
         FirebaseApp.configure()
         #if DEBUG
         let providerFactory = AppCheckDebugProviderFactory()
         AppCheck.setAppCheckProviderFactory(providerFactory)
         #endif
     }
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                 .environmentObject(authViewModel)
        }
    }
}
