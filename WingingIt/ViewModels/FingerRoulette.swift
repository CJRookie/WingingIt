//
//  FingerRoulette.swift
//  WingingIt
//
//  Created by CJ on 12/26/23.
//

import Foundation
import SwiftUI

class FingerRoulette: ObservableObject {
    @Published var timeInterval: TimeInterval = 0.5
    @Published var selectedFinger: UITouch?
    private let timer = TimerManager()
    private let soundPlayer = SoundPlayer()
    private let haptic = Haptic()
    
    func spin(_ touches: [UITouch: Touch]) {
        spinReset()
        guard !touches.isEmpty else { return }
        var elapsed: TimeInterval = 0
        timer.setupTimer(repeating: timeInterval) { [weak self] in
            guard let self = self else { return }
            if elapsed < 2 {
                elapsed += timeInterval
                selectedFinger = touches.keys.randomElement()
                soundPlayer.play()
                haptic.triggerImpactHaptics()
            } else {
                timer.cancel()
                elapsed = 0
                timer.setupTimer { [weak self] in
                    guard let self = self else { return }
                    if elapsed < 4 {
                        elapsed += timeInterval
                        selectedFinger = touches.keys.randomElement()
                        timer.schedule(deadline: .now() + timeInterval)
                        timeInterval += 0.1
                        soundPlayer.play()
                        haptic.triggerImpactHaptics()
                    } else {
                        timer.cancel()
                    }
                }
            }
        }
    }
    
    func spinReset() {
        timer.reset()
        selectedFinger = nil
        timeInterval = 0.5
    }
}
