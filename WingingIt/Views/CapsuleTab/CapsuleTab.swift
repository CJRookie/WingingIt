//
//  CapsuleTab.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct CapsuleTab: View {
    @EnvironmentObject var templateDataManager: TemplateDataManager
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var showNewTemplate = false
    @State private var showCurrentTemplate = false
    @State private var columnVisibility = NavigationSplitViewVisibility.detailOnly
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationSplitView(columnVisibility: $columnVisibility) {
                    TemplateHistory()
                } detail: {
                    detailArea
                }
            } else {
                NavigationStack {
                    detailArea
                        .toolbar { toolbarItem }
                }
            }
        }
        .sheet(isPresented: $showNewTemplate) { NavigationStack { NewTemplate() } }
        .sheet(isPresented: $showCurrentTemplate) {
            if let template = templateDataManager.selectedTemplate {
                NavigationStack { CurrentTemplate(template) }
            }
        }
        .onDisappear {
            templateDataManager.spinReset()
        }
    }
    
    private var detailArea: some View {
        ScrollView(showsIndicators: false) {
            question
            selectedOption
            availableOptions
        }
        .highPriorityGesture(swipeGesture)
        .navigationTitle(verticalSizeClass == .regular ? "" : templateDataManager.selectedTemplate?.question ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) { buttonLayout }
    }
    
    private var swipeGesture: some Gesture {
        DragGesture()
            .onEnded { value in
                templateDataManager.navigateOptionsBySwipe(translationWidth: value.translation.width)
            }
    }
    
    private var toolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                TemplateHistory()
            } label: {
                Image(systemName: "slider.horizontal.3")
            }
        }
    }
    
    private var buttonLayout: some View {
        Group {
            if verticalSizeClass == .regular {
                portraitLayout
            } else {
                landscapeLayout
            }
        }
        .padding()
        .buttonStyle(.pressableCapsuleBorder)
    }
    
    private var portraitLayout: some View {
        HStack {
            editButton
            Spacer()
            spinButton
            Spacer()
            addButton
        }
    }
    
    private var landscapeLayout: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                editButton
                addButton
            }
            Spacer()
            spinButton
        }
    }
    
    private var question: some View {
        Text(verticalSizeClass == .regular ? templateDataManager.selectedTemplate?.question ?? "" : "")
            .fontWeight(.semibold)
    }
    
    private var selectedOption: some View {
        Text(templateDataManager.selectedOption?.content ?? " ")
            .font(.title)
            .lineLimit(1, reservesSpace: true)
            .padding(.vertical)
    }
    
    private var availableOptions: some View {
        FlowLayout(spacing: 18) {
            ForEach(templateDataManager.selectedTemplate?.options?.array as? [OptionModel] ?? []) { option in
                CapsuleText(theme: option.theme, text: option.content ?? "")
                    .shadowHighlight(isSelected: option == templateDataManager.selectedOption, shadowColor: option.theme.mainColor, animationDuration: templateDataManager.timeInterval)
            }
        }
        .padding(.horizontal)
    }
    
    private var spinButton: some View {
        Button("Spin") {
            if let template = templateDataManager.selectedTemplate {
                templateDataManager.spin(template)
            }
        }
        .disabled(!isTemplateSelected)
        .opacity(isTemplateSelected ? 1 : 0.5)
    }
    
    private var addButton: some View {
        Button {
            showNewTemplate.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private var editButton: some View {
        Button {
            showCurrentTemplate.toggle()
        } label: {
            Image(systemName: "square.and.pencil")
        }
        .disabled(!isTemplateSelected)
        .opacity(isTemplateSelected ? 1 : 0.5)
    }
    
    private var isTemplateSelected: Bool {
        return templateDataManager.selectedTemplate != nil
    }
}
