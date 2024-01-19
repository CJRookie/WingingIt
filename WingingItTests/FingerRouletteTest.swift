//
//  FingerRouletteTest.swift
//  WingingItTests
//
//  Created by CJ on 1/8/24.
//

import XCTest
@testable import WingingIt

final class FingerRouletteTest: XCTestCase {
    var fingerRoulette: FingerRoulette!

    override func setUpWithError() throws {
        fingerRoulette = FingerRoulette()
    }

    override func tearDownWithError() throws {
        fingerRoulette = nil
    }

    func testSpin() {
        let touch1 = UITouch()
        let touch2 = UITouch()
        let touchDict = [touch1: Touch(), touch2: Touch()]
        fingerRoulette.spin(touchDict)
        let expectation = XCTestExpectation(description: "Wait for spin to complete")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) { [weak self] in
            guard let self = self else { return }
            expectation.fulfill()
            XCTAssertNotNil(fingerRoulette.selectedFinger)
            XCTAssertTrue(fingerRoulette.timeInterval > 0.5)
        }
    }
    
    func testSpinReset() {
        fingerRoulette.selectedFinger = UITouch()
        fingerRoulette.timeInterval = 1.0
        fingerRoulette.spinReset()
        XCTAssertNil(fingerRoulette.selectedFinger)
        XCTAssertEqual(fingerRoulette.timeInterval, 0.5)
    }
}
