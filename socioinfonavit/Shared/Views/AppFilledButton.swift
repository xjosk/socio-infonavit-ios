//
//  AppFilledButton.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import SwiftUI

struct AppFilledButton: View {
    let title: String
    var isEnabled = true
    var isBusy = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Group {
                if isBusy {
                    ProgressView()
                } else {
                    Text(title)
                }
            }
                .font(.headline)
                .tint(.white)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(isEnabled && !isBusy ? Color.appRed : Color.gray.opacity(0.6))
                .clipShape(Capsule())
        }
        .disabled(!isEnabled || isBusy)
    }
}

#Preview {
    Group {
        AppFilledButton(title: "Hello!", isEnabled: true) {
            
        }
        AppFilledButton(title: "Bye!", isEnabled: false) {
            
        }
    }
}
