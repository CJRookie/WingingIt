//
//  TransitionView.swift
//  WingingIt
//
//  Created by CJ on 1/7/24.
//

import SwiftUI

struct TransitionView: View {
    @State private var isLoading = false
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Choice")
            ZStack {
                Text("Pal")
                    .scaleEffect(isLoading ? 0 : 1)
                    .rotationEffect(.degrees(isLoading ? -540 : 0))
                VStack(spacing: 8) {
                    AnimatableStar(isLoading: isLoading, fontSize: 20, rotationDegree: -30, xOffset: -8, delay: 1.5)
                    AnimatableStar(isLoading: isLoading, fontSize: 16, delay: 1)
                    AnimatableStar(isLoading: isLoading, fontSize: 12, rotationDegree: 30, xOffset: -16, delay: 0.5)
                }
            }
        }
        .animation(.easeInOut(duration: 1), value: isLoading)
        .font(.system(size: 36, weight: .bold))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .foregroundStyle(.white)
        .background(.blue)
        .opacity(isLoading ? 0 : 1)
        .animation(.easeOut(duration: 0.1).delay(2.5), value: isLoading)
        .onAppear {
            isLoading = true
        }
    }
}
