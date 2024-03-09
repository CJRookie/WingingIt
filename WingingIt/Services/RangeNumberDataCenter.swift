//
//  RangeNumberDataCenter.swift
//  WingingIt
//
//  Created by CJ on 1/20/24.
//

import Foundation
import SwiftData

class RangeNumberDataCenter {
    static let share = RangeNumberDataCenter()
    private let container: ModelContainer
    let context: ModelContext
    
    private init() {
        do {
            container = try ModelContainer(for: RangeNumber.self)
            context = ModelContext(container)
            context.autosaveEnabled = false
        } catch {
            fatalError("Failed to create container for 'RangeNumber'.")
        }
    }
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Unable to save data to persistent stores: \(error)")
        }
    }
}
