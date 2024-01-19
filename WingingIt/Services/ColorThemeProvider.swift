//
//  ColorThemeProvider.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation

final class ColorThemeProvider {
    var allColorThemes: [ColorTheme]
    
    init(allColorThemes: [ColorTheme] = ColorTheme.allCases) {
        self.allColorThemes = allColorThemes.shuffled()
    }
    
    func getColorTheme() -> ColorTheme {
        if !allColorThemes.isEmpty {
            return allColorThemes.removeLast()
        } else {
            allColorThemes = ColorTheme.allCases.shuffled()
            return allColorThemes.removeLast()
        }
    }
}
