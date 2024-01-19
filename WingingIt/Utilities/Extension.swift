//
//  Extension.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        self.prefix(1).capitalized + self.dropFirst()
    }
    func splitAndRemoveEmpty(by separator: CharacterSet) -> [String] {
        self.components(separatedBy: separator).map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
    }
}

extension OptionModel {
    var theme: ColorTheme {
        get {
            guard let themeString = themeString, let colorTheme = ColorTheme(rawValue: themeString) else {
                return .bubblegum
            }
            return colorTheme
        }
        set {
            themeString = newValue.rawValue
        }
    }
}
