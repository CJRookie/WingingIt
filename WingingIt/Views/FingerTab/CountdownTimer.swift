//
//  CountdownTimer.swift
//  WingingIt
//
//  Created by CJ on 12/26/23.
//

import SwiftUI

struct CountdownTimer: View {
    @EnvironmentObject var fingerRoulette: FingerRoulette
    @State private var timer: Timer?
    @State private var countdown = 3
    @Binding var touches: [UITouch: Touch]
    @Binding var isRandomizing: Bool
    
    var body: some View {
        Text(countdown.description)
            .fontWeight(.semibold)
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background()
            .clipShape(.rect(cornerRadius: 16))
            .shadow(radius: 1)
            .onChange(of: touches.count) { oldValue, newValue in
                if newValue > oldValue {
                    countdown = 3
                    isRandomizing = false
                }
            }
            .onAppear(perform: start)
            .onDisappear {
                stop()
                fingerRoulette.spinReset()
                isRandomizing = false
            }
    }
    
    private func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                stop()
                isRandomizing = true
                fingerRoulette.spin(touches)
            }
        }
    }
    
    private func stop() {
        timer?.invalidate()
        timer = nil
    }
}
