//
//  MutliOptionsVMTest.swift
//  WingingItTests
//
//  Created by CJ on 1/8/24.
//

import XCTest
@testable import WingingIt

final class MutliOptionsVMTest: XCTestCase {
    var multiOptions: MultiOptionsViewModel!

    override func setUpWithError() throws {
        multiOptions = MultiOptionsViewModel()
    }

    override func tearDownWithError() throws {
        multiOptions = nil
    }
    
    func testAddMultiOptions() throws {
        let input = "Option 1, 2\nOption 2, 3\nOption 3"
        var template = Template(question: "", options: [])
        try multiOptions.addMultiOptions(with: input, to: &template)
        XCTAssertEqual(template.options.count, 3)
        XCTAssertEqual(template.options[0].content, "Option 1")
        XCTAssertEqual(template.options[0].weight, 2)
        XCTAssertEqual(template.options[1].content, "Option 2")
        XCTAssertEqual(template.options[1].weight, 3)
        XCTAssertEqual(template.options[2].content, "Option 3")
        XCTAssertEqual(template.options[2].weight, 1)
    }
}
