//
//  HighlightShadow.swift
//  WingingIt
//
//  Created by CJ on 12/26/23.
//

import SwiftUI

struct ShadowHighlight: ViewModifier {
    var isSelected: Bool
    var shadowColor: Color
    var animationDuration: Double
    
    func body(content: Content) -> some View {
        content
            .shadow(color: isSelected ? shadowColor : .clear, radius: 8)
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .animation(.spring(response: animationDuration), value: isSelected)
    }
}

extension View {
    func shadowHighlight(isSelected: Bool, shadowColor: Color, animationDuration: Double) -> some View {
        modifier(ShadowHighlight(isSelected: isSelected, shadowColor: shadowColor, animationDuration: animationDuration))
    }
}

