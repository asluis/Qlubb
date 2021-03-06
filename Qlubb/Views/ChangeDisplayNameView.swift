//
//  ChangeDisplayNameView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct ChangeDisplayNameView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    
    @State private var name = ""
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            //Alert handler
            Button(action: {
                    print("Show login alert")
                
            }, label: {
                Text("")
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            })
            .hidden()
            
            Text("Set Display Name")
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("This name will be shown publically. It must be between 3 and 15 characters.")
                .padding(.bottom)
            
            CustomStyledTextField(text: $name, placeholder: "Display Name", symbolName: "person", isSecure: false)
                .padding(.bottom)
            
            CustomStyledButton(title: "Set Name", action: {
                if name.count > 15 {
                    // Name too long
                    alertTitle = "Name too long"
                    alertMsg = "Your display name cannot be longer than 15 characters"
                    showingAlert = true
                } else {
                    if name.count < 3{
                        // Name too short
                        alertTitle = "Name too short"
                        alertMsg = "Your display name must be at least 3 characters"
                        showingAlert = true
                    } else {
                        // Name satisfies conditions
                        // If user is signed in
                        if let user = Auth.auth().currentUser {
                            // Create profile change request
                            let userChangeRequest = user.createProfileChangeRequest()
                            userChangeRequest.displayName = name
                            
                            //MARK: - Commit changes
                            userChangeRequest.commitChanges { err in
                                if let err = err {
                                    // Error
                                    alertTitle = "Failed"
                                    alertMsg = err.localizedDescription
                                    showingAlert = true
                                } else {
                                    // Success
                                    alertTitle = "Success"
                                    alertMsg = "Your display name has been changed to " + name
                                    showingAlert = true
                                    
                                    self.navigationStack.push(UIDView())
                                }
                            }
                        }
                    }
                }
            })
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ChangeDisplayNameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeDisplayNameView()
    }
}
