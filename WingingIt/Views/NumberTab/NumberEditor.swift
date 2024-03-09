//
//  NumberEditor.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import SwiftUI
import SwiftData

struct NumberEditor: View {
    @Environment(NumberDrawCenter.self) private var numDrawCenter
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
        .sheet(isPresented: $showCancellationAlert) {
            CancellationAlert(showCancellationAlert: $showCancellationAlert, save: save) {
                dismiss()
                numDrawCenter.resume()
            }
        }
        .onChange(of: numDrawCenter.rangeNumberList) {
            isChanged = true
        }
        .onAppear {
            numDrawCenter.spinReset()
        }
        .onDisappear {
            numDrawCenter.resume()
        }
    }
    
    private var numberPatterns: some View {
        List {
            ForEach(numDrawCenter.rangeNumberList) { number in
                NumberFields(rangeNumber: number, isChanged: $isChanged)
            }
            .onDelete(perform: numDrawCenter.delete)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)))
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private var errorPrompt: some View {
        if numGenError != nil {
            Text(numGenError?.localizedDescription ?? "")
                .redAlert()
                .onTapGesture {
                    numGenError = nil
                }
        }
    }
    
    @ToolbarContentBuilder
    private var toolBarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", action: cancel)
        }
        ToolbarItem {
            Button(action: numDrawCenter.add) {
                Image(systemName: "plus")
            }
        }
        ToolbarItem {
            Button(action: save) {
                Image(systemName: "square.and.arrow.down")
            }
        }
    }
    
    private func cancel() {
        isChanged ? showCancellationAlert.toggle() : dismiss()
    }
    
    private func save() {
        do {
            if try numDrawCenter.validate() {
                numDrawCenter.save()
                dismiss()
            }
        } catch {
            numGenError = error as? NumGenError
        }
    }
}
