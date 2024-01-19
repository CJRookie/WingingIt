//
//  PressableCapsuleBorder.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct PressableCapsuleBorder: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .fontWeight(.black)
            .monospaced()
            .padding(18)
            .background(
                Capsule()
                    .fill(.white)
                    .shadow(radius: configuration.isPressed ? 5 : 2)
            )
    }
}

extension ButtonStyle where Self == PressableCapsuleBorder {
    static var pressableCapsuleBorder: PressableCapsuleBorder {
        PressableCapsuleBorder()
    }
}
