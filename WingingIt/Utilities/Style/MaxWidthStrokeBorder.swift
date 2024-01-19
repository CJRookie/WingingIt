//
//  MaxWidthStrokeBorder.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct MaxWidthStrokeBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(radius: 2)
            )
            .padding(.horizontal, 12)
            .foregroundStyle(.blue)
    }
}

extension View {
    func maxWidthStrokeBorder() -> some View {
        modifier(MaxWidthStrokeBorder())
    }
}
