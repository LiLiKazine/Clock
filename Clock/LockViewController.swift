//
//  ViewController.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/25.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Combine

class LockViewController: UIViewController {

    @IBOutlet weak var timePlateView: TimePlateView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    private var targetTime: [Int] = [12, 0, 0]
    private var verifyNum: Int?
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePlateView.timeSubject
            .sink { time in
                let timeStr = String(format: "%02d : %02d : %02d", time[0], time[1], time[2])
                self.timeLabel.text = timeStr
                self.verify(time)
        }
        .store(in: &subscriptions)
        
        timePlateView.activeSubject
            .sink { time in
                self.verifyNum = 0
        }
        .store(in: &subscriptions)
        
    }
    
    private func verify(_ time: [Int]) {
        if verifyNum == 5 {
            unlock()
        } else if verifyNum != nil &&
            time[0] % 12 == targetTime[0] % 12 &&
            time[1] == targetTime[1] {
            verifyNum! += 1
        } else {
            verifyNum = nil
        }
    }
    
    private func unlock() {
        performSegue(withIdentifier: "unlock", sender: self)
    }

}


