//
//  ForgotPasswordView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var email = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    var body: some View {
        VStack {
            //Alert handler
            Button(action: {
                print("Alert")
            }, label: {
                Text("")
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            })
            
            Text("Forgot Password")
                .font(.largeTitle)
                .padding()
            Text("We will email you a link to reset your password")
                .padding(.bottom)
            
            CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "envelope", isSecure: false)
                .padding(.bottom)
            
            CustomStyledButton(title: "Reset Password", action: {
                Auth.auth().sendPasswordReset(withEmail: email, completion: { err in
                    if let err = err {
                        // Something went wrong
                        alertTitle = "Reset failed"
                        alertMsg = err.localizedDescription
                        showingAlert = true
                    } else {
                        // Success
                        alertTitle = "Reset sent"
                        alertMsg = "Check your email for a link to reset your password"
                        showingAlert = true
                        self.presentationMode.wrappedValue.dismiss() // Pop to last view
                    }
                })
            })
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
