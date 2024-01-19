//
//  NumberCard.swift
//  WingingIt
//
//  Created by CJ on 1/13/24.
//

import SwiftUI

struct NumberCard: View {
    var selectedNumber: Int?
    
    var body: some View {
        Text(selectedNumber?.description ?? "?")
            .font(.system(size: 24, weight: .bold))
            .frame(width: 80, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .padding(2)
                    .shadow(radius: 2)
            )
    }
}
