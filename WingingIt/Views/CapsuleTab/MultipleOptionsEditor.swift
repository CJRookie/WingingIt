//
//  MultipleOptionsEditor.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct MultipleOptionsEditor: View {
    @EnvironmentObject var templateDataManager: TemplateDataManager
    @Environment(\.dismiss) var dismiss
    @State private var vm = MultiOptionsViewModel()
    @State private var text: String = ""
    @State private var mOptionError: MultiOptionsError?
    @Binding var template: Template
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .top) {
                TextEditor(text: $text)
                    .autocorrectionDisabled(true)
                textEditorPrompt
                errorPrompt
            }
        }
        .navigationTitle("Add Multiple Options")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarItems
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var errorPrompt: some View {
        if mOptionError != nil {
            Text(mOptionError?.localizedDescription ?? "")
                .redAlert()
                .onTapGesture {
                    mOptionError = nil
                }
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") { dismiss() }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Save", action: save)
        }
    }
    
    private func save() {
        do {
            try vm.addMultiOptions(with: text, to: &template)
            dismiss()
        } catch {
            mOptionError = error as? MultiOptionsError
        }
    }
    
    @ViewBuilder
    private var textEditorPrompt: some View {
        if text.isEmpty {
            Text("Enter your options, with each option on a new line or separated by semicolons. After each option, specify its weight by separating it with a comma. If no specific weight is provided or the weight is invalid, the default assignment is 1.\ne.g.\nBlue\nGreen, 2\nRed, 5\nor\nBlue, 3; Green, 2; Red, 5\nor\nBlue; Green, 1; Red, 1\nYellow, 5; Blue, 3")
                .allowsHitTesting(false)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.secondary)
                .padding(EdgeInsets(top: 7, leading: 1, bottom: 0, trailing: 0))
        }
    }
}
