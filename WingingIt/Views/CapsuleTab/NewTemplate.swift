//
//  NewTemplate.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct NewTemplate: View {
    @State private var template: Template = Template(question: "", options: [Option(content: "")])
    
    var body: some View {
        TemplateEditor(mode: .adding, template: $template)
    }
}

