//
//  TimerManagerTest.swift
//  WingingItTests
//
//  Created by CJ on 1/7/24.
//

import XCTest
@testable import WingingIt

final class TimerManagerTest: XCTestCase {
    var timerManager: TimerManager!

    override func setUpWithError() throws {
        timerManager = TimerManager()
    }

    override func tearDownWithError() throws {
        timerManager = nil
    }

    func testSetupTimer() {
        let expectation = self.expectation(description: "Timer fired")
        timerManager.setupTimer(deadline: .now() + 1, repeating: 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
