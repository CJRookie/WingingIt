//
//  MultiTouchRecognizer.swift
//  WingingIt
//
//  Created by CJ on 11/30/23.
//

import Foundation
import SwiftUI

class MultiTouchRecognizer: UIGestureRecognizer {
    private var touchCallbacks: ([UITouch: Touch]) -> Void
    private(set) var touchData = [UITouch: Touch]()
    private var touchCancelled: (Bool) -> Void
    private let colorThemeProvider = ColorThemeProvider()
    
    init(target: Any?, touchCallbacks: @escaping ([UITouch: Touch]) -> (), touchCancelled: @escaping (Bool) -> Void) {
        self.touchCallbacks = touchCallbacks
        self.touchCancelled = touchCancelled
        super.init(target: target, action: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        touches.forEach { 
            touchData[$0] = Touch(color: assignColor())
        }
        updateTouches(touches)
        touchCallbacks(touchData)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        updateTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        removeTouches(touches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        removeTouches(touches)
        touchCancelled(true)
    }
    
    private func updateTouches(_ touches: Set<UITouch>) {
        touches.forEach { touchData[$0]?.location = $0.location(in: $0.view) }
        touchCallbacks(touchData)
        touches.forEach {
            touchData[$0]?.isAnimating = true
        }
        withAnimation(.easeInOut(duration: 1)) {
            touchCallbacks(touchData)
        }
        touchCancelled(false)
    }
    
    private func removeTouches(_ touches: Set<UITouch>) {
        touches.forEach {
            touchData.removeValue(forKey: $0)
        }
        touchCallbacks(touchData)
    }
    
    private func assignColor() -> Color {
        colorThemeProvider.getColorTheme().mainColor
    }
}
