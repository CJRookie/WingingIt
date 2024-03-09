//
//  HomeTab.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import SwiftUI

struct HomeTab: View {
    @State private var selection: Tab = .capsule
    
    enum Tab: String {
        case capsule
        case finger
        case number
        
        var title: String {
            rawValue.capitalized
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CapsuleTab()
                .tabItem {
                    Label(Tab.capsule.title, systemImage: "bubbles.and.sparkles")
                }
                .tag(Tab.capsule)
            FingerTab()
                .tabItem {
                    Label(Tab.finger.title, systemImage: "hand.point.up.braille")
                }
                .tag(Tab.finger)
            NumberTab()
                .tabItem {
                    Label(Tab.number.title, systemImage: "dice")
                }
                .tag(Tab.number)
        }
    }
}
