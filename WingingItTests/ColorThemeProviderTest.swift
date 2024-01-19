//
//  ColorThemeProviderTest.swift
//  WingingItTests
//
//  Created by CJ on 1/7/24.
//

import XCTest
@testable import WingingIt

final class ColorThemeProviderTest: XCTestCase {
    var colorThemeProvider: ColorThemeProvider!
    
    override func setUpWithError() throws {
        colorThemeProvider = ColorThemeProvider()
    }

    override func tearDownWithError() throws {
        colorThemeProvider = nil
    }

    func testGetColorTheme() {
        let colorThemes = ColorTheme.allCases
        var themeArray: [ColorTheme] = []
        
        for _ in 0..<colorThemes.count {
            themeArray.append(colorThemeProvider.getColorTheme())
        }
        
        // no repeating color theme occurs until all color themes are exhausted
        let themeSet = Set(themeArray)
        XCTAssertEqual(themeArray.count, themeSet.count)
        
        // repeating color theme occurs after all color themes are exhausted
        let theme = colorThemeProvider.getColorTheme()
        XCTAssertTrue(themeSet.contains(theme))
    }
}
