//
//  RangeNumberList.swift
//  WingingIt
//
//  Created by CJ on 1/15/24.
//

import Foundation
import SwiftData

struct RangeNumberList: Identifiable, Hashable {
    var id: UUID = UUID()
    var lowerBound: Int = 0
    var upperBound: Int = 100
    var count: Int = 1
    var isResultRepeatable: Bool = false
    var colorTheme: ColorTheme = .bubblegum
}

@Model final class RangeNumber {
    @Attribute(.unique) var range: ClosedRange<Int>
    var count: Int
    var isResultRepeatable: Bool
    @Transient var colorTheme: ColorTheme = .bubblegum
    
    init(range: ClosedRange<Int> = 0...100, count: Int = 1, isResultRepeatable: Bool = false, colorTheme: ColorTheme = .bubblegum) {
        self.range = range
        self.count = count
        self.isResultRepeatable = isResultRepeatable
        self.colorTheme = colorTheme
    }
}
