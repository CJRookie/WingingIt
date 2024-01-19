//
//  CurrentTemplate.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct CurrentTemplate: View {
    @State private var template: Template
    
    init(_ template: TemplateModel) {
        var options: [Option] = []
        if let optionArray = template.options?.array as? [OptionModel] {
            options = optionArray.map { Option(content: $0.content ?? "", weight: $0.weight) }
        }
        _template = State(initialValue: Template(question: template.question ?? "", options: options))
    }
    
    var body: some View {
        TemplateEditor(mode: .editing, template: $template)
    }
}
