//
//  TimerManager.swift
//  WingingIt
//
//  Created by CJ on 11/14/23.
//

import Foundation

final class TimerManager {
    private var timer: DispatchSourceTimer?
    
    func setupTimer(queue: DispatchQueue = .main, deadline: DispatchTime = .now(), repeating: TimeInterval? = nil, eventHandler: @escaping () -> Void, cancelHandler: (() -> Void)? = nil) {
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.setEventHandler(handler: eventHandler)
        timer?.setCancelHandler(handler: cancelHandler)
        schedule(deadline: deadline, repeating: repeating)
        timer?.activate()
    }
    
    func cancel() {
        timer?.cancel()
    }
    
    func schedule(deadline: DispatchTime, repeating: TimeInterval? = nil) {
        if let repeating = repeating {
            timer?.schedule(deadline: deadline, repeating: repeating)
        } else {
            timer?.schedule(deadline: deadline)
        }
    }
    
    func reset() {
        cancel()
        timer = nil
    }
}
