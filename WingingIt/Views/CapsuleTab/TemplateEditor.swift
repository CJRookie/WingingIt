//
//  TemplateEditor.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct TemplateEditor: View {
    @EnvironmentObject var templateDataManager: TemplateDataManager
    @Environment(\.dismiss) var dismiss
    @State private var templateError: TemplateError?
    @State private var showCancellationAlert = false
    @State private var isChanged = false
    @State private var showMultipleOptionsEditor = false
    private let mode: TemplateEditorMode
    @Binding var template: Template
    @State private var templateID: String
    
    init(mode: TemplateEditorMode, template: Binding<Template>) {
        self.mode = mode
        _template = template
        _templateID = State(wrappedValue: template.id)
    }
    
    var body: some View {
        ZStack {
            Form {
                questionSection
                optionSection
            }
            .autocorrectionDisabled(true)
            errorPrompt
        }
        .navigationTitle(mode == .adding ? "Create a New Template" : "Edit Template")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { toolbarItems }
        .sheet(isPresented: $showMultipleOptionsEditor) {
            NavigationStack { MultipleOptionsEditor(template: $template) }
        }
        .sheet(isPresented: $showCancellationAlert) {
            CancellationAlert(showCancellationAlert: $showCancellationAlert, save: save) { dismiss() }
        }
        .onChange(of: template) {
            isChanged = true
        }
    }
    
    @ViewBuilder
    private var errorPrompt: some View {
        if templateError == .insufficientOptions || templateError == .duplicateOption || templateError == .duplicateQuestion {
            Text(templateError?.localizedDescription ?? "")
                .redAlert()
                .onTapGesture {
                    templateError = nil
                }
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel", action: cancel)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Save", action: save)
        }
    }
    
    private func cancel() {
        isChanged ? showCancellationAlert.toggle() : dismiss()
    }
    
    private func save() {
        do {
            if try templateDataManager.validate(template, mode: mode) {
                switch mode {
                case .adding: 
                    templateDataManager.add(template)
                case .editing:
                    templateDataManager.update(templateID, with: template)
                    templateID = template.id
                }
                dismiss()
            }
        } catch {
            showCancellationAlert = false
            templateError = error as? TemplateError
        }
    }
    
    private var addNewButton: some View {
        Button("Add new option") {
            templateError = nil
            template.options.append(Option(content: ""))
        }
        .disabled(template.options.last?.content.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
    }
    
    private var addMultipleButton: some View {
        Button("Add multiple options") {
            templateError = nil
            showMultipleOptionsEditor.toggle()
        }
    }
    
    private var questionSection: some View {
        Section {
            TextField("Question",
                      text: $template.question,
                      prompt: Text("Enter your question").foregroundStyle(templateError == .emptyQuestion ? .red : .gray.opacity(0.5))
            )
        } header: {
            Text("Question")
        }
    }
    
    private var optionSection: some View {
        Section {
            options
            addNewButton
            addMultipleButton
        } header: {
            HStack {
                Text("Options")
                Spacer()
                Text("Weights")
            }
        }
    }
    
    private var options: some View {
        ForEach($template.options) { option in
            HStack {
                TextField("Option",
                          text: option.content,
                          prompt: Text("Enter your option").foregroundStyle(templateError == .emptyOption ? .red : .gray.opacity(0.5))
                )
                Divider()
                TextField("Weight", value: option.weight, formatter: weightFormater)
                    .frame(width: 56)
                    .keyboardType(.numberPad)
            }
        }
        .onDelete(perform: delete)
    }
    
    private func delete(at offsets: IndexSet) {
        template.options.remove(atOffsets: offsets)
    }
}

enum TemplateEditorMode {
    case adding
    case editing
}
