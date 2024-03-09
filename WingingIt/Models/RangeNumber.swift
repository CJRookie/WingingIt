//
//  RangeNumber.swift
//  WingingIt
//
//  Created by CJ on 1/15/24.
//

import Foundation
import SwiftData

@Model final class RangeNumber: Equatable, Hashable, Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var dateOfCreation: Date
    var lowerBound: Int
    var upperBound: Int
    var count: Int
    var isResultRepeatable: Bool
    var theme: String
    
    init(dateOfCreation: Date = Date.now, lowerBound: Int = 0, upperBound: Int = 100, count: Int = 1, isResultRepeatable: Bool = false, theme: String = ColorTheme.bubblegum.name) {
        self.dateOfCreation = dateOfCreation
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        self.count = count
        self.isResultRepeatable = isResultRepeatable
        self.theme = theme
    }
}

extension RangeNumber {
    func update(with other: RangeNumber) {
        count = other.count
        isResultRepeatable = other.isResultRepeatable
        lowerBound = other.lowerBound
        upperBound = other.upperBound
    }
}
