//
//  InteractiveCircle.swift
//  WingingIt
//
//  Created by CJ on 11/25/23.
//

import SwiftUI

struct InteractiveCircle: View {
    @EnvironmentObject var fingerRoulette: FingerRoulette
    var mainColor: Color
    var isAnimating: Bool
    var location: CGPoint
    var isSelected: Bool
    @Binding var isRandomizing: Bool
    
    var body: some View {
        Circle()
            .frame(width: frameSize, height: frameSize)
            .shadowHighlight(isSelected: isSelected, shadowColor: mainColor, animationDuration: fingerRoulette.timeInterval)
            .overlay {
                overlayContent
            }
            .opacity(isSelected ? 1 : 0.7)
            .foregroundStyle(mainColor)
            .position(location)
    }
    
    @ViewBuilder
    private var overlayContent: some View {
        if !isRandomizing {
            Circle()
                .stroke(lineWidth: 1)
                .pulse(isAnimating: isAnimating, shadowColor: mainColor)
        }
    }
    
    private var frameSize: CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 100 : 150
    }
}
