//
//  NumberFields.swift
//  WingingIt
//
//  Created by CJ on 1/14/24.
//

import SwiftUI

struct NumberFields: View {
    @Bindable var rangeNumber: RangeNumber
    @Binding var isChanged: Bool
    
    var colorTheme: ColorTheme {
        ColorTheme(rawValue: rangeNumber.theme) ?? .bubblegum
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Range")
                        .foregroundStyle(colorTheme.accentColor)
                    HStack {
                        TextField("From", value: $rangeNumber.lowerBound, format: .number)
                            .onChange(of: rangeNumber.lowerBound) {
                                isChanged = true
                            }
                        TextField("To", value: $rangeNumber.upperBound, format: .number)
                            .onChange(of: rangeNumber.upperBound) {
                                isChanged = true
                            }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Repeat Count")
                        .foregroundStyle(colorTheme.accentColor)
                    TextField("Count", value: $rangeNumber.count, format: .number)
                        .onChange(of: rangeNumber.count) {
                            isChanged = true
                        }
                }
                .frame(width: 110)
            }
            VStack(alignment: .leading) {
                Toggle("Allow duplicate results", isOn: $rangeNumber.isResultRepeatable)
                    .foregroundStyle(colorTheme.accentColor)
                    .onChange(of: rangeNumber.isResultRepeatable) {
                        isChanged = true
                    }
            }
        }
        .lineLimit(1)
        .textFieldStyle(.roundedBorder)
        .autocorrectionDisabled(true)
        .keyboardType(.numberPad)
        .padding()
        .background(colorTheme.mainColor.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
