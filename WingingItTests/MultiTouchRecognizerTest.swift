//
//  MultiTouchRecognizerTest.swift
//  WingingItTests
//
//  Created by CJ on 1/8/24.
//

import XCTest
@testable import WingingIt

final class MultiTouchRecognizerTest: XCTestCase {
    var recognizer: MultiTouchRecognizer!

    override func setUpWithError() throws {
        recognizer = MultiTouchRecognizer(target: nil, touchCallbacks: { _ in }, touchCancelled: { _ in })
    }

    override func tearDownWithError() throws {
        recognizer = nil
    }

    func testAllTouchesOperations() throws {
        let touch1 = UITouch()
        let touch2 = UITouch()
        let touches: Set<UITouch> = [touch1, touch2]
        let event = UIEvent()
        recognizer.touchesBegan(touches, with: event)
        XCTAssertEqual(recognizer.touchData.count, 2)
        recognizer.touchesMoved(touches, with: event)
        XCTAssertTrue(recognizer.touchData.values.allSatisfy { $0.isAnimating == true })
        recognizer.touchesEnded([touch1], with: event)
        XCTAssertEqual(recognizer.touchData.count, 1)
        recognizer.touchesCancelled(touches, with: event)
        XCTAssertEqual(recognizer.touchData.count, 0)
    }
}
