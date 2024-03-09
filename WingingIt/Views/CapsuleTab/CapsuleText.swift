//
//  CapsuleText.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct CapsuleText: View {
    let theme: ColorTheme
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 16))
            .lineLimit(2)
            .foregroundColor(theme.accentColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(8)
            .background(Capsule().fill(theme.mainColor))
    }
}
