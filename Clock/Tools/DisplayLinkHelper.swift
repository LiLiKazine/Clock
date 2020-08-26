//
//  DisplayLinkHelper.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/26.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Combine

class DisplayLinkHelper {
    
    let invokeSubject: PassthroughSubject<CFTimeInterval, Error>
        
    init() {
        invokeSubject = .init()
    }
    
    @objc func invoke(_ displayLink: CADisplayLink) {
        invokeSubject.send(displayLink.timestamp)
    }
    
    deinit {
        print("DisplayLinkHelper Deinited.")
    }

}
