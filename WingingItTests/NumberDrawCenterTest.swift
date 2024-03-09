//
//  NumberDrawCenterTest.swift
//  WingingItTests
//
//  Created by CJ on 1/24/24.
//

import XCTest
@testable import WingingIt

final class NumberDrawCenterTest: XCTestCase {
    var numberDrawCenter: NumberDrawCenter!

    override func setUpWithError() throws {
        numberDrawCenter = NumberDrawCenter()
    }

    override func tearDownWithError() throws {
        if !numberDrawCenter.rangeNumberList.isEmpty {
            numberDrawCenter.delete(at: IndexSet(0..<numberDrawCenter.rangeNumberList.count))
        }
        numberDrawCenter = nil
    }
    
    func testInit() {
        XCTAssertFalse(numberDrawCenter.rangeNumberList.isEmpty)
        XCTAssertFalse(numberDrawCenter.selectedNumberArray.isEmpty)
    }
    
    func testAdd() {
        numberDrawCenter.add()
        numberDrawCenter.save()
        XCTAssertTrue(numberDrawCenter.rangeNumberList.count > 1)
    }
    
    func testDelete() {
        numberDrawCenter.delete(at: IndexSet(integersIn: 0...numberDrawCenter.rangeNumberList.count))
        numberDrawCenter.save()
        XCTAssertTrue(numberDrawCenter.rangeNumberList.isEmpty)
    }
    
    func testResume() {
        // resume after adding
        for _ in 0..<5 {
            numberDrawCenter.add()
        }
        print(numberDrawCenter.rangeNumberList.count)
        numberDrawCenter.resume()
        XCTAssertEqual(numberDrawCenter.rangeNumberList.count, 1)
        
        // resume after deleting
        for _ in 0..<5 {
            numberDrawCenter.add()
        }
        numberDrawCenter.save()
        numberDrawCenter.delete(at: IndexSet(integersIn: 0..<3))
        XCTAssertEqual(numberDrawCenter.rangeNumberList.count, 3)
    }
    
    func testInvalid() {
        let invalidNumberRange = RangeNumber(lowerBound: 10, upperBound: 10)
        let insufficientCandidates = RangeNumber(lowerBound: 0, upperBound: 5, count: 10)
        
        // test invalid number range
        numberDrawCenter.rangeNumberList.first?.update(with: invalidNumberRange)
        XCTAssertThrowsError(try numberDrawCenter.validate(), "Invalid number range should throw an error") { error in
            XCTAssertEqual(error as? NumGenError, NumGenError.invalidNumberRange, "Error thrown should be NumGenError.invalidNumberRange")
        }
        
        //test insufficient candidates
        numberDrawCenter.rangeNumberList.first?.update(with: insufficientCandidates)
        XCTAssertThrowsError(try numberDrawCenter.validate(), "Insufficient candidates should throw an error") { error in
            XCTAssertEqual(error as? NumGenError, NumGenError.insufficientCandidates, "Error thrown should be NumGenError.insufficientCandidates")
        }
    }
}
