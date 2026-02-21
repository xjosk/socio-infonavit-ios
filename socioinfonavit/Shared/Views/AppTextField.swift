//
//  AppTextField.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import SwiftUI

struct AppTextField<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(.vertical)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray),
                alignment: .bottom
            )
            .frame(height: 40)
    }
}
