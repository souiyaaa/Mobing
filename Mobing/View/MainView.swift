//
//  MainView.swift
//  ALP_Jevon_Carry
//
//  Created by Daffa Khoirul on 20/05/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var showAuthSheet = false
    var body: some View {
        TabView{
            HomeView().tabItem{
                Label("Home", systemImage: "house")
            } 
            
            ListCarView().tabItem{
                Label("List Car", systemImage: "car")
            }
            
        }
        .onAppear {
            showAuthSheet = !authViewModel.isSigneIn
        }.sheet(isPresented: $showAuthSheet){
            LoginRegisterSheet(showAuthSheet: $showAuthSheet)
        }
    }
}


#Preview {
    MainView()
        .environmentObject(AuthViewModel(repository: FirebaseAuthRepository()))
    
}
