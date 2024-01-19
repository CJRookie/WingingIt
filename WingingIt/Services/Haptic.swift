//
//  Haptic.swift
//  WingingIt
//
//  Created by CJ on 11/25/23.
//

import Foundation
import UIKit

final class Haptic {
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    func triggerImpactHaptics() {
        impactGenerator.impactOccurred()
    }
}
    
