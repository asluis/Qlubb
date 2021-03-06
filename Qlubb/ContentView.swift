//
//  ContentView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        if Auth.auth().currentUser != nil {
            // User is signed in
            
            if Auth.auth().currentUser?.displayName == nil {
                ChangeDisplayNameView()
            } else {
                UIDView()
            }
        } else {
            // User is not signed in
            TitleView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
