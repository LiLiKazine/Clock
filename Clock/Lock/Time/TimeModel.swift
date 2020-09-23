//
//  TimeModel.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/26.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Combine

class TimeModel {
    
    let timeSubject: PassthroughSubject<Time, Never>
    
    private var displayLink: CADisplayLink?
    
    private var subscriptions: Set<AnyCancellable>
    
    private weak var updateHelper: DisplayLinkHelper?
    
    private var startTime: Time?
    
    private var accumulation: Int = 0
    
    private let maxSeconds: Int = 24 * 60 * 60
    
    init() {
        timeSubject = .init()
        subscriptions = []
    }
        
    func start() {
        
        updateCurrentTime()
        accumulation = 0

        startLink()
        
    }
    
    
    func startLink() {
        let helper = DisplayLinkHelper()
        
        helper.invokeSubject
            .sink(receiveValue: { timeInterval in
                self.formTime(timeInterval)
            })
            .store(in: &subscriptions)
        
        displayLink?.invalidate()
        displayLink = .init(target: helper, selector: #selector(helper.invoke(_:)))
        displayLink?.add(to: .current, forMode: .default)
        displayLink?.preferredFramesPerSecond = 1
        updateHelper = helper
        
    }
    
    func stopLink() {
        displayLink?.invalidate()
    }
    
    func updateTime(_ time: Time) {
        startTime = time
        accumulation = 0
    }
    
    private func formTime(_ timeInterval: CFTimeInterval) {
        guard let baseTime = startTime else {
            print("Start time is Nil.")
            displayLink?.invalidate()
            return
        }
        accumulate()
        let target = (accumulation + baseTime.totalSeconds) % maxSeconds
        let time = Time(target)
        timeSubject.send(time)
    }
    
    private func updateCurrentTime()  {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        guard let hour = components.hour,
            let minute = components.minute,
            let second = components.second else {
                print("Update current time failed.")
                return
        }
        startTime = Time(hour, minute, second)
    }
    
    private func accumulate() {
        accumulation += 1
        if accumulation + startTime!.totalSeconds > maxSeconds {
            startTime = .init(0)
            accumulation = 1
        }
    }
    
    deinit {
        stopLink()
        print("TimeModel Deinited.")
    }

}

extension TimeModel {
    struct Time {
        let hour: Int
        let min: Int
        let sec: Int
        
        var totalSeconds: Int {
            return hour * 60 * 60 + min * 60 + sec
        }
        
        init(_ h: Int, _ m: Int, _ s: Int) {
            hour = h
            min = m
            sec = s
        }
        
        init(_ seconds: Int) {
            hour = seconds / 60 / 60
            min = seconds / 60 % 60
            sec = seconds % 60 % 60
        }
        
    }
}
