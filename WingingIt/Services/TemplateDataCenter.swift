//
//  TemplateDataCenter.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation
import CoreData

final class TemplateDataCenter {
    static let shared = TemplateDataCenter()
    private let containerName = "TemplateData"
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Unable to save data to persistent stores: \(error)")
        }
    }
}
