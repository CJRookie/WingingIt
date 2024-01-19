//
//  AnimatableStar.swift
//  WingingIt
//
//  Created by CJ on 1/10/24.
//

import SwiftUI

struct AnimatableStar: View {
    var isLoading: Bool
    var fontSize: CGFloat
    var rotationDegree: Double = 0
    var xOffset: CGFloat = 0
    var animationDuration: TimeInterval = 1
    var delay: TimeInterval
    
    var body: some View {
        Image(systemName: "star")
            .font(.system(size: fontSize))
            .rotationEffect(.degrees(rotationDegree), anchor: .center)
            .offset(x: xOffset)
            .opacity(isLoading ? 1 : 0)
            .animation(.easeInOut(duration: animationDuration).delay(delay), value: isLoading)
    }
}
