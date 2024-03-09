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
    var order: Int16
    
    init(question: String, options: [Option], order: Int16 = 0) {
        self.question = question
        self.options = options
        self.order = order
    }
}
