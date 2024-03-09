//
//  NumberCard.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import SwiftUI

struct NumberCard: View {
    var selectedNumber: Int?
    private var frameWidth: CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 80 : 120
    }
    private var frameHeight: CGFloat {
        UIDevice.current.userInterfaceIdiom == .phone ? 100 : 150
    }
    
    var body: some View {
        Text(selectedNumber?.description ?? "?")
            .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 24, weight: .bold))
            .frame(width: frameWidth, height: frameHeight)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .padding(2)
                    .shadow(radius: 2)
            )
    }
}
