//
//  NumberDrawCenter.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import Foundation
import SwiftUI
import SwiftData

class NumberDrawCenter: ObservableObject {
    @Published var rangeNumberLists: [RangeNumberList] = [] {
        didSet {
            setupSelectedNumArray()
        }
    }
    @Published var selectedNumArray: [Int?] = []
    let colorThemeProvider: ColorThemeProvider = ColorThemeProvider()
    private let timer: TimerManager = TimerManager()
    private let soundPlayer: SoundPlayer = SoundPlayer()
    private let haptic: Haptic =  Haptic()
    
    init() {
        rangeNumberLists.append(RangeNumberList(colorTheme: colorThemeProvider.getColorTheme()))
    }

    func setupSelectedNumArray() {
        selectedNumArray = rangeNumberLists.flatMap { list in
            Array(repeating: nil, count: list.count)
        }
    }
    
    func validate() throws {
        try rangeNumberLists.forEach { list in
            if !list.isResultRepeatable {
                let range = list.lowerBound...list.upperBound
                if list.count > range.count {
                    throw NumGenError.InsufficientCandidatesError
                }
            }
        }
    }
    
    private func generateRandomNum(from list: RangeNumberList) -> [Int] {
        var array: [Int] = []
        let range = list.lowerBound...list.upperBound
        if list.isResultRepeatable {
            for _ in 0..<list.count {
                array.append(Int.random(in: range))
            }
        } else {
            var candidates = Array(range)
            for _ in 0..<list.count {
                let index = Int.random(in: 0..<candidates.count)
                array.append(candidates[index])
                candidates.remove(at: index)
            }
        }
        return array
    }
    
    func spin() {
        spinReset()
        guard !rangeNumberLists.isEmpty else { return }
        var elapsed: TimeInterval = 0
        var timeInterval: TimeInterval = 0.1
        timer.setupTimer(repeating: timeInterval) { [weak self] in
            guard let self = self else { return }
            if elapsed < 2 {
                elapsed += timeInterval
                selectedNumArray = rangeNumberLists.flatMap { list in
                    self.generateRandomNum(from: list)
                }
                soundPlayer.play()
                haptic.triggerImpactHaptics()
            } else {
                timer.cancel()
                elapsed = 0
                timer.setupTimer { [weak self] in
                    guard let self = self else { return }
                    if elapsed < 4 {
                        elapsed += timeInterval
                        selectedNumArray = rangeNumberLists.flatMap { list in
                            self.generateRandomNum(from: list)
                        }
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
    }
}
