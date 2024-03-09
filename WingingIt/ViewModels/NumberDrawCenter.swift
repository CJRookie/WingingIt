//
//  NumberDrawCenter.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import Foundation
import SwiftData

@Observable class NumberDrawCenter {
    private let rangeNumberDataCenter = RangeNumberDataCenter.share
    private let context: ModelContext
    private(set) var rangeNumberList: [RangeNumber] = []
    private var rangeNumberRefList: [RangeNumber] = []
    private var rangeNumberResumeValueRef: [RangeNumber] = []
    private(set) var selectedNumberArray: [Int?] = []
    private let colorThemeProvider = ColorThemeProvider()
    private let timer: TimerManager = TimerManager()
    private let soundPlayer: SoundPlayer = SoundPlayer()
    private let haptic: Haptic =  Haptic()
    
    init() {
        context = rangeNumberDataCenter.context
        fetch()
        initSetup()
    }
    
    func initSetup() {
        if rangeNumberList.isEmpty {
            let theme = colorThemeProvider.getColorTheme().rawValue
            context.insert(RangeNumber(theme: theme))
            fetch()
        }
    }
    
    func resume() {
        rangeNumberList = rangeNumberRefList
        rangeNumberList.forEach { rangeNumber in
            if let reference = rangeNumberResumeValueRef.first(where: { $0.dateOfCreation == rangeNumber.dateOfCreation }) {
                rangeNumber.update(with: reference)
            }
        }
    }
    
    func save() {
        if !rangeNumberList.isEmpty {
            let added = Set(rangeNumberList).subtracting(rangeNumberRefList)
            added.forEach { context.insert($0) }
        }
        
        let removed = Set(rangeNumberRefList).subtracting(rangeNumberList)
        removed.forEach { context.delete($0) }
        rangeNumberDataCenter.save()
        fetch()
    }
    
    func add() {
        let theme = colorThemeProvider.getColorTheme().rawValue
        rangeNumberList.append(RangeNumber(theme: theme))
    }
    
    func delete(at indexSet: IndexSet) {
        rangeNumberList.remove(atOffsets: indexSet)
    }
    
    func fetch() {
        do {
            let descriptor = FetchDescriptor<RangeNumber>(sortBy: [SortDescriptor(\.dateOfCreation)])
            rangeNumberList = try context.fetch(descriptor)
            rangeNumberRefList = rangeNumberList
            setupRangeNumberResumeValueRef()
            setupSelectedNumArray()
        } catch {
            print("Unable to fetch the request: \(error)")
        }
    }
    
    private func setupRangeNumberResumeValueRef() {
        rangeNumberResumeValueRef = rangeNumberList.map {
            RangeNumber(dateOfCreation: $0.dateOfCreation, lowerBound: $0.lowerBound, upperBound: $0.upperBound, count: $0.count, isResultRepeatable: $0.isResultRepeatable, theme: $0.theme)
        }
    }
    private func setupSelectedNumArray() {
        selectedNumberArray = rangeNumberList.flatMap { rangeNumber in
            Array<Int?>(repeating: nil, count: rangeNumber.count)
        }
    }
    
    func validate() throws -> Bool {
        for rangeNumber in rangeNumberList {
            if rangeNumber.lowerBound >= rangeNumber.upperBound {
                throw NumGenError.invalidNumberRange
            }
            if !rangeNumber.isResultRepeatable {
                let range = rangeNumber.lowerBound...rangeNumber.upperBound
                if rangeNumber.count > range.count {
                    throw NumGenError.insufficientCandidates
                }
            }
        }
        return true
    }
    
    private func generateRandomNum(from list: RangeNumber) -> [Int] {
        var array: [Int] = []
        let range = list.lowerBound...list.upperBound
        if list.isResultRepeatable {
            array = (0..<list.count).map { _ in Int.random(in: range) }
        } else {
            var candidates = Array(range)
            array = (0..<list.count).map { _ in
                let index = Int.random(in: 0..<candidates.count)
                let element = candidates.remove(at: index)
                return element
            }
        }
        return array
    }
    
    func spin() {
        spinReset()
        guard !rangeNumberList.isEmpty else { return }
        var elapsed: TimeInterval = 0
        var timeInterval: TimeInterval = 0.1
        timer.setupTimer(repeating: timeInterval) { [weak self] in
            guard let self = self else { return }
            if elapsed < 2 {
                elapsed += timeInterval
                selectedNumberArray = rangeNumberList.flatMap { list in
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
                        selectedNumberArray = rangeNumberList.flatMap { list in
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
