//
//  ColorTheme.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation
import SwiftUI

enum ColorTheme: String, CaseIterable, Identifiable, Equatable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .poppy, .seafoam, .tan, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .periwinkle, .purple, .sky, .teal: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue
    }
    
    var id: String {
        name
    }
}
