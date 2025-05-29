//
//  HomeView.swift
//  Mobing
//
//  Created by Daffa Khoirul on 23/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedQuizType: String = ""
    let cornerRadius: CGFloat = 30
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack{
            Text("Home")
                .font(.title)
            Button(action: {
                self.authVM.signOut()
            }) {
                Text("Sign Out")
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel(repository: FirebaseAuthRepository()))
}
