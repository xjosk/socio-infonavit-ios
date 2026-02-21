//
//  LoginHeaderView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import SwiftUI

struct LoginHeaderBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.8))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX / 2, y: rect.maxY * 0.9),
            control: CGPoint(x: rect.maxX * 0.8, y: rect.maxY * 0.8)
            )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY),
            control: CGPoint(x: rect.maxX * 0.1, y: rect.maxY * 1.05)
            )
        path.closeSubpath()

        return path
    }
}

#Preview {
    GeometryReader { proxy in
        LoginHeaderBackground()
            .fill(.appRed)
            .frame(height: proxy.size.height * 3/7)
            .ignoresSafeArea()
    }
}
