//
//  SoundPlayerTest.swift
//  WingingItTests
//
//  Created by CJ on 1/7/24.
//

import XCTest
@testable import WingingIt

final class SoundPlayerTest: XCTestCase {
    var soundPlayer: SoundPlayer!
    
    override func setUpWithError() throws {
        soundPlayer = SoundPlayer(fileName: "Du", fileExtension: "mp3")
    }

    override func tearDownWithError() throws {
        soundPlayer = nil
    }

    func testPlay() throws {
        let expectation = self.expectation(description: "Sound played")
        soundPlayer.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
