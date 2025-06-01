//
//  LoginView.swift
//  ALP_Jevon_Carry
//
//  Created by Daffa Khoirul on 16/05/25.
//


import SwiftUI

struct LoginRegisterSheet: View {
    @Binding var showAuthSheet: Bool
    @EnvironmentObject var authVM: AuthViewModel
    @State var registerClicked: Bool = true
    
    var body: some View {
        ZStack {
            // Background
            Color(.systemBackground)
                .ignoresSafeArea()
            
            // Content
            
            VStack(spacing: 20) {
                // Header
                if registerClicked {
                    Image("Image1").resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.top, 20)

                }
                
                if !registerClicked {
                    Spacer()
                }
                
                Text(registerClicked ? "Login" : "Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                
                // Form Fields
                VStack(spacing: 16) {
                    if !registerClicked {
                        CustomTextField(
                            placeholder: "Name",
                            text: $authVM.myUser.username
                        )
                        
                        
                    }
                    
                    CustomTextField(
                        placeholder: "Email",
                        text: $authVM.myUser.email
                    )
                    .keyboardType(.emailAddress)
                    
                    
                    CustomSecureField(
                        placeholder: "Password",
                        text: $authVM.myUser.password
                    )
                    
                    if authVM.falseCredential {
                        Text("Invalid Username and Password")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                
                // Action Button
                Button(action: {
                    Task {
                        if registerClicked {
                            await authVM.signIn()
                            if !authVM.falseCredential {
                                authVM.checkUserSession()
                                showAuthSheet = !authVM.isSigneIn
                                authVM.myUser = UserModel()
                            }
                        } else {
                            await authVM.singUp()
                            if !authVM.falseCredential {
                                authVM.checkUserSession()
                                showAuthSheet = !authVM.isSigneIn
                                authVM.myUser = UserModel()
                            }
                        }
                    }
                }) {
                    Text(registerClicked ? "Login" : "Register")
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                Spacer()
                
                // Toggle Button
                Button(action: {
                    withAnimation {
                        registerClicked.toggle()
                        authVM.falseCredential = false
                    }
                }) {
                    Text(registerClicked ? "Don't have an account? Register" : "Already have an account? Login")
                        .foregroundColor(.blue)
                }
                .padding(.bottom)
                Spacer()
            }
           
        }
        .interactiveDismissDisabled(true)
        .padding(.horizontal, 20)    }
}

// Custom Text Field Component



//password harus 8
#Preview {
    LoginRegisterSheet(
        showAuthSheet:
                .constant(true)
    )
    .environmentObject(
        AuthViewModel(repository: FirebaseAuthRepository())
    )
}


