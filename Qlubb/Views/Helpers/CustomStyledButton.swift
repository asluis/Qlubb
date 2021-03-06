//
//  CustomStyledButton.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI

struct CustomStyledButton: View {
    private var osTheme: UIUserInterfaceStyle {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    var title: String
    var action: () -> Void
    var backgroundColor: Color? {
        if osTheme == UIUserInterfaceStyle.dark {
            return .white
        } else {
            return .black
        }
    }
    var textColor: Color? {
        if osTheme == UIUserInterfaceStyle.dark {
            return .black
        } else {
            return .white
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .padding()
                    .accentColor(.white)
                    .font(.title2)
                    .foregroundColor(textColor)
                Spacer()
            }
        }
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct CustomStyledButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyledButton(title: "Hello", action: { print(":)") })
    }
}
