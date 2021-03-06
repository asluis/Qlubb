//
//  CustomStyledText.swift
//  Qlubb
//
//  Created by Ethan Hanlon on 3/5/21.
//

import SwiftUI

struct CustomStyledText: View {
    private var osTheme: UIUserInterfaceStyle {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    var title: String
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
        HStack {
            Spacer()
            Text(title)
                .padding()
                .accentColor(.white)
                .font(.title2)
                .foregroundColor(textColor)
            Spacer()
        }
        .background(backgroundColor)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct CustomStyledText_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyledText(title: "Hello!")
    }
}
