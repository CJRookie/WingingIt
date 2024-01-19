//
//  NumberEditorView.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import SwiftUI

struct NumberEditorView: View {
    @EnvironmentObject var numDrawCenter: NumberDrawCenter
    @Environment(\.dismiss) var dismiss
    @State private var numGenError: NumGenError?
    @State private var isChanged = false
    @State private var showCancellationAlert = false
    
    var body: some View {
        ZStack {
            numberPatterns
            errorPrompt
        }
        .navigationTitle("Pattern Editor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{ toolBarContent }
        .padding(.horizontal)
        .onTapGesture { numGenError = nil }
        .sheet(isPresented: $showCancellationAlert) {
            CancellationAlert(showCancellationAlert: $showCancellationAlert, save: save, dismiss: dismiss)
        }
        .onChange(of: numDrawCenter.rangeNumberLists) { _, _ in
            isChanged = true
        }
        .onAppear {
            numDrawCenter.spinReset()
            numDrawCenter.setupSelectedNumArray()
        }
    }
    
    private var numberPatterns: some View {
        List {
            ForEach($numDrawCenter.rangeNumberLists) { numList in
                NumberFields(rangeNumberList: numList)
            }
            .onDelete(perform: delete)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)))
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private var errorPrompt: some View {
        if numGenError != nil {
            Text(numGenError?.localizedDescription ?? "")
                .foregroundStyle(.red)
                .padding()
                .background()
                .clipShape(.capsule)
        }
    }
    
    @ToolbarContentBuilder
    private var toolBarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", action: cancel)
        }
        ToolbarItem {
            Button {
                numDrawCenter.rangeNumberLists.append((RangeNumberList(colorTheme: numDrawCenter.colorThemeProvider.getColorTheme())))
            } label: {
                Image(systemName: "plus")
            }
        }
        ToolbarItem {
            Button(action: save) {
                Image(systemName: "square.and.arrow.down")
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        numDrawCenter.rangeNumberLists.remove(atOffsets: offsets)
    }
    
    private func cancel() {
        isChanged ? showCancellationAlert.toggle() : dismiss()
    }
    
    private func save() {
        do {
            try numDrawCenter.validate()
            dismiss()
        } catch {
            numGenError = error as? NumGenError
        }
    }
}
