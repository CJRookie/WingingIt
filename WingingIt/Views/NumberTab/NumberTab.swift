//
//  NumberTab.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import SwiftUI
import SwiftData

struct NumberTab: View {
    @Environment(NumberDrawCenter.self) private var numDrawCenter
    @State private var showNumberEditor = false
    @State private var selectedNumber: [Int?] = []
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                numberCards
            }
            .safeAreaInset(edge: .bottom) { buttonLayout }
        }
        .sheet(isPresented: $showNumberEditor) { 
            NavigationStack {
                NumberEditor()
            }
        }
        .onDisappear {
            numDrawCenter.spinReset()
        }
    }
    
    private var numberCards: some View {
        FlowLayout(spacing: UIDevice.current.userInterfaceIdiom == .pad ? 8 : 0) {
            ForEach(numDrawCenter.selectedNumberArray.indices, id: \.hashValue) { index in
                if numDrawCenter.selectedNumberArray.indices.contains(index) {
                    NumberCard(selectedNumber: numDrawCenter.selectedNumberArray[index])
                } 
            }
        }
        .padding()
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
            numDrawCenter.initSetup()
            showNumberEditor.toggle()
        } label: {
            Image(systemName: "square.and.pencil")
        }
    }
}
