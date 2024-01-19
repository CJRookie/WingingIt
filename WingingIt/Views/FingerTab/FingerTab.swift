//
//  FingerTab.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//0

import SwiftUI

struct FingerTab: View {
    @EnvironmentObject var fingerRoulette: FingerRoulette
    @State private var touches: [UITouch: Touch] = [:]
    @State private var isCancelled = false
    @State private var isRandomizing = false
    
    var body: some View {
        multiTouchView
            .overlay {
                countdownTimer
                prompt
                circles
            }
            .onDisappear {
                fingerRoulette.spinReset()
            }
    }
    
    private var multiTouchView: some View {
        MultiTouchView { touchCallbacks in
            touches = touchCallbacks
        } touchCancelled: { touchCancelled in
            isCancelled = touchCancelled
        }
    }
    
    private var circles: some View {
        ForEach(Array(touches.keys), id: \.self) { touch in
            InteractiveCircle(mainColor: touches[touch]?.color ?? .blue, isAnimating: touches[touch]?.isAnimating ?? false, location: touches[touch]?.location ?? .zero, isSelected: touch == fingerRoulette.selectedFinger, isRandomizing: $isRandomizing)
        }
    }
    
    @ViewBuilder
    private var countdownTimer: some View {
        if touches.count >= 2 {
            CountdownTimer(touches: $touches, isRandomizing: $isRandomizing)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom)
        }
    }
    
    @ViewBuilder
    private var prompt: some View {
        if touches.isEmpty {
            VStack {
                Text("Finger Roulette")
                    .font(.title2)
                Text("👆  👆  👆  👆  👆")
                    .padding(.vertical, 12)
                Text("Two to five players press and hold their fingers on the screen, waiting for 3 seconds to trigger the selection.")
                if isCancelled {
                    Text("Up to five players are allowed.")
                        .foregroundStyle(.red)
                }
            }
            .foregroundStyle(.secondary)
            .padding()
            .allowsHitTesting(false)
        }
    }
}
