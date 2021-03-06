//
//  UIDView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI
import FirebaseAuth
import NavigationStack

struct UIDView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    private var currentUser = Auth.auth().currentUser
    
    // Alert box
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var name = ""
    
    var body: some View {
        NavigationView {
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
                .hidden()
                
                //MARK: - Name and UID
                Text("Hello, " + (currentUser?.displayName ?? "human") + "!")
                    .font(.largeTitle)
                Text("Your UID is " + (currentUser?.uid ?? "not able to found right now, how odd") + "!")
                
                Divider()
                Spacer()
                
                //MARK: - Email verification
                if (currentUser?.isEmailVerified) == true {
                    // Is verified
                    HStack {
                        Image(systemName: "checkmark.circle")
                        
                        Text("Email verified")
                    }
                    .foregroundColor(.green)
                    .padding(.bottom)
                    .padding(.horizontal)
                } else {
                    // Is not verified
                    HStack {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                        
                        Text("Email not verified")
                            .foregroundColor(.red)
                        Spacer()
                        
                        Button(action: {
                            // Send verification
                            currentUser?.sendEmailVerification(completion: nil)
                            
                            alertTitle = "Verification message sent"
                            alertMsg = "Please check your email for a verification message. Check your spam/junk folder if you can't find it in your inbox."
                            showingAlert = true
                        }, label: {
                            HStack {
                                Text("Verify Email")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.green)
                            .padding(.horizontal)
                        })
                    }
                    
                    .padding(.bottom)
                    .padding(.horizontal)
                }
                
                // Link to ChangeDisplayNameView for funsies
                NavigationLink(
                    destination: ChangeDisplayNameView()) {
                        Text("Change display name")
                    }
                
                
                Spacer()
                
                //MARK: - Sign out
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        self.navigationStack.push(TitleView())
                    } catch {
                        alertTitle = "Failed to sign out"
                        alertMsg = "Something broke on our end. Try signing out again or restarting."
                        showingAlert = true
                    }
                    
                }, label: {
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                    Text("Sign out")
                })
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct UIDView_Previews: PreviewProvider {
    static var previews: some View {
        UIDView()
    }
}
