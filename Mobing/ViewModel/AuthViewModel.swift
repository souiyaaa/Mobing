//
//  AuthViewModel.swift
//  Mobing
//
//  Created by Daffa Khoirul on 23/05/25.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

@MainActor
class AuthViewModel: ObservableObject{
    
    @Published var user: User?
    @Published var currentUser: UserModel
    @Published var isSignedIn: Bool
    @Published var falseCredential: Bool
    
    init(){
        self.user = nil
        self.isSignedIn = false
        self.falseCredential = false
        self.currentUser = UserModel()
        self.checkUserSession()
        
    }
    
    func checkUserSession(){
        self.user = Auth.auth().currentUser
        self.isSignedIn = self.user != nil
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch{
            print("Sign Out Error: \(error.localizedDescription)")
        }
    }
    
    func signIn() async {
        do{
            _ = try await Auth.auth().signIn(withEmail: currentUser.email, password: currentUser.password)
            DispatchQueue.main.async {
                self.falseCredential = false
            }
        }catch{
            DispatchQueue.main.async {
                self.falseCredential = true
            }
        }
    }
    
    func singUp() async {
        let ref = Database.database().reference()
        do {
            let result = try await Auth.auth().createUser(withEmail: currentUser.email, password: currentUser.password)
            let uid = result.user.uid
            
            // Simpan data user ke Realtime Database
            let userData: [String: Any] = [
                "id": uid,
                "email": currentUser.email,
                "name": currentUser.username,
                "listOrders": currentUser.listOrders
            ]

            try await ref.child("users").child(uid).setValue(userData)
            
            DispatchQueue.main.async {
                self.falseCredential = false
                self.user = result.user
                self.isSignedIn = true
            }
        } catch {
            print("Sign Up Error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                
            }
            
        }
    }
}

