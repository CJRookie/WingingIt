//
//  WingingItApp.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import SwiftUI
import SwiftData

@main
struct WingingItApp: App {
    @StateObject private var templateDataManager = TemplateDataManager()
    @StateObject private var fingerRoulette = FingerRoulette()
    @State private var numDrawCenter = NumberDrawCenter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeTab()
                TransitionView()
            }
            .environmentObject(templateDataManager)
            .environmentObject(fingerRoulette)
            .environment(numDrawCenter)
        }
    }
}
