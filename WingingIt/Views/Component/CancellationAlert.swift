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
    var discard: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                Button("Save Changes", action: save)
                    .padding(.bottom)
                Divider()
                Button("Discard Changes", action: discard)
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
        .presentationBackground(.clear)
    }
}
