//
//  AuthView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct AuthView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
        
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    var body: some View {
        VStack {
            // Alert handler
            Button(action: {
                print("Alert")
            }, label: {
                Text("")
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            })
            
            Text("Sign In")
                .font(.largeTitle)
                .padding(.bottom)
            
            // Email field
            CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "envelope", isSecure: false)
                .padding(.bottom)
            
            // Password field
            CustomStyledTextField(text: $password, placeholder: "Password", symbolName: "lock", isSecure: true)
                .padding(.bottom)
            
            // Forgot password link
            NavigationLink(
                destination: ForgotPasswordView(),
                label: {
                    Text("Forgot?")
                    Image(systemName: "chevron.right")
                })
                .padding(.bottom)
            
            // Login button
            CustomStyledButton(title: "Log in", action: emailPasswordSignIn)
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    // MARK: - Sign in
    func emailPasswordSignIn() {
        // Make sure email and password forms are filled in
        if email == "" || password == "" {
            alertTitle = "Sign in failed"
            alertMsg = "Please enter an email and password"
            showingAlert = true
        } else {
            // Attempt to sign in with Firebase Auth
            Auth.auth().signIn(withEmail: email, password: password) { authResult, err in
                if let err = err {
                    // Something went wrong
                    alertTitle = "Sign in failed"
                    alertMsg = err.localizedDescription
                    showingAlert = true
                } else {
                    // Login successful, push to next view
                    self.navigationStack.push(UIDView())
                }
            }
        }
        
    }
}



struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
