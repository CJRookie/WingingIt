//
//  UserDefaultsManagerTests.swift
//  WingingItTests
//
//  Created by CJ on 1/7/24.
//

import XCTest
@testable import WingingIt

final class UserDefaultsManagerTests: XCTestCase {
    var userDefaultsManager: UserDefaultsManager!
    
    override func setUpWithError() throws {
        userDefaultsManager = UserDefaultsManager.shared
    }
    
    override func tearDownWithError() throws {
        userDefaultsManager = nil
    }
    
    func testUpdateSelectedTemplateID() {
        userDefaultsManager.updateSelectedTemplateID(with: "template_id")
        XCTAssertEqual(userDefaultsManager.getSelectedTemplateID(), "template_id")
    }
    
    func testUpdateHasLaunchedValue() {
        userDefaultsManager.updateHasLaunchedValue(with: true)
        XCTAssertTrue(userDefaultsManager.getHasLaunchedValue())
    }
}
