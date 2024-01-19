//
//  MultiOptionsViewModel.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import Foundation

struct MultiOptionsViewModel {
    
    func addMultiOptions(with input: String, to template: inout Template) throws {
        guard !input.isEmpty else { return }
        template.options.removeAll { $0.content.trimmingCharacters(in: .whitespaces).isEmpty }
        var templateCopy = template
        let strings = input.splitAndRemoveEmpty(by: ["\n", ";"])
        for string in strings {
            try parseOption(from: string, addTo: &templateCopy)
        }
        let optionSet = Set(templateCopy.options)
        if optionSet.count == templateCopy.options.count {
            template = templateCopy
        } else {
            throw MultiOptionsError.duplicateOption
        }
    }
    
    private func parseOption(from string: String, addTo template: inout Template) throws {
        let optionComponents = string.splitAndRemoveEmpty(by: [","])
        guard optionComponents.count <= 2 else {
            throw MultiOptionsError.invalidOptionFormat
        }
        let content = optionComponents[0].capitalizeFirstLetter()
        let weight = optionComponents.dropFirst().first.flatMap { Int16($0.trimmingCharacters(in: .whitespaces)) } ?? 1
        template.options.append(Option(content: content, weight: weight))
    }
}
