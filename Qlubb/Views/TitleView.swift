//
//  TitleView.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI

struct TitleView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Qlubb")
                    .font(.largeTitle)
                    .padding()
                
                Divider()
                Spacer()
                
                NavigationLink(
                    destination: AuthView(),
                    label: {
                        CustomStyledText(title: "Sign in")
                    })
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        CustomStyledText(title: "Register")
                            .padding(.bottom)
                    })
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
