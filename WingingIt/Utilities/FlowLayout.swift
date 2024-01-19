//
//  FlowLayout.swift
//  WingingIt
//
//  Created by CJ on 11/18/23.
//

import SwiftUI

struct FlowLayout: Layout {
    private let spacing: CGFloat
    
    init(spacing: CGFloat = 0) {
        self.spacing = spacing
    }
    
    private func maxSize(subviews: Subviews, proposedWidth: Double) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize = sizes.reduce(.zero) {
            CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height))
        }
        let maxWidth = min(maxSize.width, (proposedWidth + spacing) / 2)
        let maxHeight = max(maxSize.height, maxWidth / 2)
        return CGSize(width: max(1, maxWidth), height: maxHeight)
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        let proposedWidth = proposal.replacingUnspecifiedDimensions().width
        let subviewSize = maxSize(subviews: subviews, proposedWidth: proposedWidth)
        let rowCount = (proposedWidth + spacing) / (subviewSize.width + spacing)
        let subviewInRow = min(max(rowCount, 1), CGFloat(subviews.count))
        let subviewInColumn = Double(subviews.count) / floor(subviewInRow)
        let height = (subviewSize.height + spacing) * ceil(subviewInColumn) - spacing
        return CGSize(width: proposedWidth, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        let width = bounds.width
        let subviewSize = maxSize(subviews: subviews, proposedWidth: width)
        let placementProposal = ProposedViewSize(subviewSize)
        let subviewInRow = min((width + spacing) / (subviewSize.width + spacing), CGFloat(subviews.count))
        let adjustX = (width + spacing - floor(subviewInRow) * (subviewSize.width + spacing)) / 2.0
        var origin = CGPoint(x: bounds.minX + adjustX, y: bounds.minY)
        for subview in subviews {
            if origin.x + subviewSize.width > width + bounds.origin.x {
                origin.x = bounds.minX + adjustX
                origin.y += subviewSize.height + spacing
            }
            subview.place(at: origin, proposal: placementProposal)
            origin.x += subviewSize.width + spacing
        }
    }
}
