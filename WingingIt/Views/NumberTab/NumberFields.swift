//
//  NumberFields.swift
//  WingingIt
//
//  Created by CJ on 1/14/24.
//

import SwiftUI

struct NumberFields: View {
    @Binding var rangeNumberList: RangeNumberList
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Range")
                        .foregroundStyle(rangeNumberList.colorTheme.accentColor)
                    HStack {
                        TextField("From", value: $rangeNumberList.lowerBound, format: .number)
                        TextField("To", value: $rangeNumberList.upperBound, format: .number)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Repeat Count")
                        .foregroundStyle(rangeNumberList.colorTheme.accentColor)
                    TextField("Count", value: $rangeNumberList.count, format: .number)
                }
                .frame(width: 110)
            }
            VStack(alignment: .leading) {
                Toggle("Allow duplicate results", isOn: $rangeNumberList.isResultRepeatable)
                    .foregroundStyle(rangeNumberList.colorTheme.accentColor)
            }
        }
        .lineLimit(1)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
        .padding()
        .background(rangeNumberList.colorTheme.mainColor.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
