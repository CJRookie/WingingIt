//
//  TemplateRow.swift
//  WingingIt
//
//  Created by CJ on 1/11/24.
//

import SwiftUI

struct TemplateRow: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var templateDataManager: TemplateDataManager
    var isSelected: Bool
    var template: TemplateModel
    @Binding var tempTemplate: TemplateModel?
    var height: CGFloat = 45
    
    var body: some View {
        HStack(spacing: 2) {
            Button(template.question ?? "") {
                templateDataManager.updateSelectedTemplate(with: template.id ?? "")
                dismiss()
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, maxHeight: height, alignment: .leading)
            .background(isSelected ? .blue : .blue.opacity(0.1))
            Button {
                tempTemplate = template
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .buttonStyle(.plain)
            .frame(maxWidth: height, maxHeight: height, alignment: .center)
            .background(isSelected ? .orange : .orange.opacity(0.1))
        }
        .clipShape(.buttonBorder)
        .foregroundStyle(isSelected ? .white : .black)
    }
}
