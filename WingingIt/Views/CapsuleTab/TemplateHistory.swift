//
//  TemplateHistory.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct TemplateHistory: View {
    @EnvironmentObject var templateDataManager: TemplateDataManager
    @Environment(\.dismiss) var dismiss
    @State private var showNewTemplate = false
    @State private var tempTemplate: TemplateModel?
    
    var body: some View {
        templateList
            .navigationTitle("History")
            .sheet(item: $tempTemplate) { templateModel in
                NavigationStack { CurrentTemplate(templateModel) }
            }
            .sheet(isPresented: $showNewTemplate) { NavigationStack { NewTemplate() } }
            .toolbar { toolbarItem }
    }
    
    private var templateList: some View {
        List {
            ForEach(templateDataManager.templates) { template in
                TemplateRow(isSelected: template.id == templateDataManager.selectedTemplate?.id, template: template, tempTemplate: $tempTemplate)
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
            .listRowSeparator(.hidden)
            .listRowInsets(.init())
        }
        .listStyle(.plain)
        .padding(.horizontal)
    }
    
    private var toolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showNewTemplate.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        templateDataManager.delete(at: offsets)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        templateDataManager.move(from: source, to: destination)
    }
}
