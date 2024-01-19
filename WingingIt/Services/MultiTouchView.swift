//
//  MultiTouchView.swift
//  WingingIt
//
//  Created by CJ on 12/26/23.
//

import Foundation
import SwiftUI

struct MultiTouchView: UIViewRepresentable {
    var touchCallbacks: ([UITouch: Touch]) -> Void
    var touchCancelled: (Bool) -> Void
    
    func makeUIView(context: UIViewRepresentableContext<MultiTouchView>) -> MultiTouchView.UIViewType {
        let v = UIView(frame: .zero)
        let gesture = MultiTouchRecognizer(target: context.coordinator, touchCallbacks: touchCallbacks, touchCancelled: touchCancelled)
        v.addGestureRecognizer(gesture)
        return v
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<MultiTouchView>) {
        
    }
}
