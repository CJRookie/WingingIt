//
//  TemplateDataManagerTest.swift
//  WingingItTests
//
//  Created by CJ on 1/8/24.
//

import XCTest
@testable import WingingIt

final class TemplateDataManagerTest: XCTestCase {
    var dataManager: TemplateDataManager!
    
    override func setUpWithError() throws {
        dataManager = TemplateDataManager()
    }
    
    override func tearDownWithError() throws {
        dataManager = nil
    }
    
    func testInitSetup() {
        XCTAssertTrue(dataManager.templates.count >= 1)
    }
    
    func testValidate() {
        // test empty question
        let emptyQuestionTemplate = Template(question: "", options: [Option(content: "Option 1", weight: 50), Option(content: "Option 2", weight: 50)])
        XCTAssertThrowsError(try dataManager.validate(emptyQuestionTemplate), "Empty question should throw an error") { error in
            XCTAssertEqual(error as? TemplateError, TemplateError.emptyQuestion, "Error thrown should be TemplateError.emptyQuestion")
        }
        
        // test duplicate questions
        let duplicateQuestionTemplate = Template(question: "Pick a color", options: [])
        XCTAssertThrowsError(try dataManager.validate(duplicateQuestionTemplate, mode: .adding), "Duplicate question should throw an error") { error in
            XCTAssertEqual(error as? TemplateError, TemplateError.duplicateQuestion, "Error thrown should be TemplateError.duplicateQuestion")
        }
        
        // test empty option
        let emptyOptionTemplate = Template(question: "Question", options: [Option(content: "", weight: 50), Option(content: "Option 2", weight: 50)])
        XCTAssertThrowsError(try dataManager.validate(emptyOptionTemplate), "Empty option should throw an error") { error in
            XCTAssertEqual(error as? TemplateError, TemplateError.emptyOption, "Error thrown should be TemplateError.emptyOption")
        }
        
        // test duplicate option
        let duplicateOptionTemplate = Template(question: "Question", options: [Option(content: "duplicate option"), Option(content: "duplicate option")])
        XCTAssertThrowsError(try dataManager.validate(duplicateOptionTemplate), "Duplicate question should throw an error") { error in
            XCTAssertEqual(error as? TemplateError, TemplateError.duplicateOption, "Error thrown should be TemplateError.duplicateOption")
        }
        
        // test insufficient options
        let insufficientOptionsTemplate = Template(question: "Question", options: [Option(content: "Option 1", weight: 50)])
        XCTAssertThrowsError(try dataManager.validate(insufficientOptionsTemplate), "Insufficient options should throw an error") { error in
            XCTAssertEqual(error as? TemplateError, TemplateError.insufficientOptions, "Error thrown should be TemplateError.insufficientOptions")
        }
        
        // test valid template
        let validTemplate = Template(question: "Question", options: [Option(content: "Option 1", weight: 50), Option(content: "Option 2", weight: 50)])
        XCTAssertNoThrow(try dataManager.validate(validTemplate), "Valid template should not throw an error")
    }
    
    func testTemplateOperations() {
        // adding template
        let template = Template(question: "Test template", options: [Option(content: "Test content")])
        dataManager.add(template)
        XCTAssertTrue(dataManager.templates.contains { $0.question == "Test template" })
        
        // updating template
        let updateTemplate = Template(question: "Update template", options: [Option(content: "Updated content")])
        dataManager.update(template.id, with: updateTemplate)
        XCTAssert(dataManager.templates.contains { $0.question == "Update template" })
        XCTAssertFalse(dataManager.templates.contains { $0.question == "Test template" })
        
        // deleting template, updating selectedTemplate to be the first element in the templates
        dataManager.delete(at: IndexSet(integer: dataManager.templates.count - 1))
        XCTAssertFalse(dataManager.templates.contains { $0.question == "Update template" })
        XCTAssertEqual(dataManager.selectedTemplate?.id, dataManager.templates[0].id)
        
        // moving template position
        dataManager.add(Template(question: "Moving template1", options: [Option(content: "option 1"), Option(content: "option 2")]))
        dataManager.add(Template(question: "Moving template2", options: [Option(content: "option 1"), Option(content: "option 2")]))
        XCTAssertTrue(dataManager.templates.count == 3)
        dataManager.move(from: IndexSet(integer: 0), to: 1)
        for index in 0..<dataManager.templates.count {
            XCTAssertEqual(index, Int(dataManager.templates[index].order))
        }
        print(dataManager.templates)
    }
}
