//
//  CancellationAlert.swift
//  WingingIt
//
//  Created by CJ on 1/17/24.
//

import SwiftUI

struct CancellationAlert: View {
    @Binding var showCancellationAlert: Bool
    var save: () -> Void
    var dismiss: DismissAction
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Button("Save Changes", action: save)
                    .padding(.bottom)
                Divider()
                Button("Discard Changes") { dismiss() }
                    .padding(.top)
                    .foregroundStyle(.red)
            }
            .maxWidthStrokeBorder()
            Button {
                showCancellationAlert.toggle()
            } label: {
                Text("Cancel")
                    .maxWidthStrokeBorder()
            }
        }
        .presentationDetents([.height(180)])
        .presentationBackground(.clear)
    }
}
