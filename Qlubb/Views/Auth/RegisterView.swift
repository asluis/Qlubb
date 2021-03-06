//
//  RegisterView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct RegisterView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var usrMessage = ""
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
            
            Text("Register")
                .font(.largeTitle)
                .padding(.bottom)
            
            CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "envelope", isSecure: false)
                .padding(.bottom)
            
            CustomStyledTextField(text: $password, placeholder: "Password", symbolName: "lock", isSecure: true)
                .padding(.bottom)
            
            CustomStyledTextField(text: $passwordConfirm, placeholder: "Confirm Password", symbolName: "lock", isSecure: true)
                .padding(.bottom)
            
            CustomStyledButton(title: "Sign up", action: emailPasswordRegister)
            .padding(.bottom)
            
            Divider()
            
            //Terms/privacy
            HStack {
                
                Link("Terms", destination: URL(string: "https://www.example.com")!)
                
                Text("•")
                
                Link("Privacy", destination: URL(string: "https://www.example.com")!)
            }
            .padding(.top)
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    //MARK: - Check email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: - Create Account
    func emailPasswordRegister() {
        //Check for email
        if(isValidEmail(email)) {
            //Check for min password length & matching
            if(password.count >= 8) {
                //Check for passwords matching
                if(password == passwordConfirm) {
                    // Attempt to create user
                    Auth.auth().createUser(withEmail: email, password: password) {authResult,error in
                        guard let user = authResult?.user, error == nil else {
                            // Something went wrong
                            alertTitle = "Error"
                            alertMsg = error!.localizedDescription
                            showingAlert = true
                            return
                        }
                        // User creation successful, push to next view
                        sleep(UInt32(0.5))
                        user.sendEmailVerification(completion: nil)
                        self.navigationStack.push(ChangeDisplayNameView())
                    }
                } else {
                    alertTitle = "Passwords don't match"
                    alertMsg = "The passwords fields do not match with each other."
                    showingAlert = true
                }
            } else {
                alertTitle = "Password not long enough"
                alertTitle = "Your password must be at least 8 characters."
                showingAlert = true
            }
        } else {
            alertTitle = "Please enter an email address"
            alertMsg = "Either the email field was left empty, or a valid email was not entered."
            showingAlert = true
        }
    }
}




struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
