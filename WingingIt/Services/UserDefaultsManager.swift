//
//  UserDefaultsManager.swift
//  WingingIt
//
//  Created by CJ on 11/16/23.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let selectedTemplateKey = "selectedTemplateKey"
    private let hasLaunchedKey = "hasLaunchedKey"
    private init() {}
    
    func updateSelectedTemplateID(with id: String? = nil) {
        UserDefaults.standard.set(id, forKey: selectedTemplateKey)
    }

    func getSelectedTemplateID() -> String? {
        return UserDefaults.standard.string(forKey: selectedTemplateKey)
    }

    func updateHasLaunchedValue(with value: Bool) {
        UserDefaults.standard.set(value, forKey: hasLaunchedKey)
    }

    func getHasLaunchedValue() -> Bool {
        return UserDefaults.standard.bool(forKey: hasLaunchedKey)
    }
}
