//
//  Formatter.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import Foundation

let weightFormater: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    formatter.maximum = 100
    formatter.minimum = 1
    return formatter
}()
