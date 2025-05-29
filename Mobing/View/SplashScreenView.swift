//
//  SplashScreenView.swift
//  Mobing
//
//  Created by Daffa Khoirul on 29/05/25.
//

import Foundation


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
          HomeView()
        } else {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    
                Text("MOBING")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, -20)
                    .foregroundColor(.white)
                
                Spacer()
                Text("By UD Maju Sentosa")
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.bottom, 50)
                    .foregroundColor(.white)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("skyBlue"))
                .ignoresSafeArea()
            .onAppear {
                // Waktu tampil splash screen dalam detik
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(
            AuthViewModel(repository: FirebaseAuthRepository())
        )
}
