//
//  PulsingEffect.swift
//  WingingIt
//
//  Created by CJ on 12/31/23.
//

import SwiftUI

struct PulsingEffect: ViewModifier {
    var isAnimating: Bool
    var shadowColor: Color
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating ? 1.5 : 1)
            .shadow(color: shadowColor, radius: isAnimating ? 10 : 0)
            .opacity(isAnimating ? 0 : 1)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
    }
}

extension View {
    func pulse(isAnimating: Bool, shadowColor: Color) -> some View {
        modifier(PulsingEffect(isAnimating: isAnimating, shadowColor: shadowColor))
    }
}
