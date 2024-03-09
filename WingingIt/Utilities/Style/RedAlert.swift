//
//  RedAlert.swift
//  WingingIt
//
//  Created by CJ on 1/22/24.
//

import SwiftUI

struct RedAlert: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(radius: 1)
            )
            .foregroundStyle(.red)
    }
}

extension View {
    func redAlert() -> some View {
        modifier(RedAlert())
    }
}
