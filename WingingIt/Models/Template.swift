//
//  Template.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation

struct Template: Identifiable, Equatable {
    var id: String {
        question.trimmingCharacters(in: .whitespaces)
    }
    var question: String
    var options: [Option]
    
    init(question: String, options: [Option]) {
        self.question = question.capitalizeFirstLetter()
        self.options = options
    }
}
