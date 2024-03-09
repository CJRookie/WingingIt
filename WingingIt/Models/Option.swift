//
//  Option.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation
import SwiftUI

struct Option: Identifiable, Equatable, Hashable {
    var id = UUID()
    var content: String
    var weight: Int16
    
    init(content: String, weight: Int16 = 1) {
        self.content = content.capitalizeFirstLetter()
        self.weight = weight
    }
}
