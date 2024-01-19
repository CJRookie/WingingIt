//
//  NumberTab.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import SwiftUI

struct NumberTab: View {
    @EnvironmentObject var numDrawCenter: NumberDrawCenter
    @State private var showNumberEditor = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                numberCards
            }
            .safeAreaInset(edge: .bottom) { buttonLayout }
        }
        .sheet(isPresented: $showNumberEditor) { 
            NavigationStack {
                NumberEditorView()
            }
        }
        .onDisappear { numDrawCenter.spinReset() }
    }
    
    private var numberCards: some View {
        FlowLayout {
            ForEach(numDrawCenter.selectedNumArray.indices, id: \.hashValue) { index in
                NumberCard(selectedNumber: numDrawCenter.selectedNumArray[index])
            }
        }
        .padding(.vertical)
    }
    
    private var buttonLayout: some View {
        ZStack {
            spinButton
            editButton
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .buttonStyle(.pressableCapsuleBorder)
    }
    
    private var spinButton: some View {
        Button("Spin") {
            numDrawCenter.spin()
        }
    }
    
    private var editButton: some View {
        Button {
            showNumberEditor.toggle()
        } label: {
            Image(systemName: "square.and.pencil")
        }
    }
}

struct NumberTabView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Text("Hello")
    }
}
