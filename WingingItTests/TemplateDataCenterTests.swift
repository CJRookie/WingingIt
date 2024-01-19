//
//  TemplateDataCenterTests.swift
//  WingingItTests
//
//  Created by CJ on 1/6/24.
//

import XCTest
import CoreData
@testable import WingingIt

final class TemplateDataCenterTests: XCTestCase {
    var dataCenter: TemplateDataCenter!

    override func setUpWithError() throws {
        dataCenter = TemplateDataCenter.shared
    }

    override func tearDownWithError() throws {
        dataCenter = nil
    }

    func testSaveAndFetchFromCoreData() throws {
        let entityName = "TemplateModel"
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: dataCenter.context)!
        let object = NSManagedObject(entity: entityDescription, insertInto: dataCenter.context)
        object.setValue("Sample Question", forKey: "question")
        dataCenter.save()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let fetchedObjects = try dataCenter.context.fetch(fetchRequest) as! [NSManagedObject]
            XCTAssertTrue(fetchedObjects.count > 0, "No objects fetched from the persistent store.")
            XCTAssertTrue(fetchedObjects.contains(where: { $0.value(forKey: "question") as? String == "Sample Question" }))
        } catch {
            XCTFail("Failed to fetch objects with error: \(error)")
        }
    }
}
