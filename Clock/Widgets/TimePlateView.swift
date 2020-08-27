//
//  TimePlateView.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/25.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Combine

class TimePlateView: UIView {
    
    var outlineWidth: CGFloat = 3.0
    var scaleWith: CGFloat = 1.0
    var scaleLength: CGFloat = 6.0
    var hourScaleLength: CGFloat = 12.0
    var spacing: CGFloat = 2.0
    
    let hourHand = CAShapeLayer()
    let minHand = CAShapeLayer()
    let secHand = CAShapeLayer()
    
    private var outlinePath: CGPath?
    private var scalePath: CGPath?
    
    private var currentTime: [Int] = [0, 0, 0]
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let model = TimeModel()
    
    private var touchPoint: CGPoint = .zero
    private var lastPoint: CGPoint = .zero
    
    @objc func panHourHand(_ gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            print("Begin panning.")
            touchPoint = gesture.location(in: self)
            model.stopLink()
            
        case .changed:
            let translate = gesture.translation(in: self)
            let dest = translate.applying(.init(translationX: touchPoint.x-bounds.width/2, y: touchPoint.y-bounds.height/2))
            let velocity = gesture.velocity(in: self)
            if lastPoint.x * dest.x < 0 && dest.y < 0 {
                let hour = (24 + currentTime[0] + (velocity.x > 0 ? 1 : -1)) % 24
                currentTime[0] = hour
            }
            let angle = point2value(dest)
            let ratio = angle / (CGFloat.pi * 2)
            let minute = Int(60*ratio)
            currentTime[1] = minute
            animateHands()
            lastPoint = dest
        case .ended:
            print("End panning.")
            model.updateTime(.init(currentTime[0], currentTime[1], currentTime[2]))
            model.startLink()
        default:
            print("gesture: ", gesture.state)
        }
        
    }
    
    private func point2value(_ point: CGPoint) -> CGFloat {
        let radius = min(bounds.width, bounds.height) / 2
        let scaleR = sqrt(pow(point.x, 2) + pow(point.y, 2))
        let x = point.x / scaleR * radius
        
        var angle = asin(x / radius) / CGFloat.pi
        if point.y > 0 {
            angle = 1 - angle
        }
        
        if point.x < 0 && point.y <= 0 {
            angle = 2 + angle
        }

        return angle * CGFloat.pi
    }
    
    private func animateHands() {
        guard currentTime.count == 3  else { return }
        let toAngle: (Int, CGFloat) -> CGFloat = { val, denominator in
            let angle = CGFloat(val) / denominator * CGFloat.pi * 2
            return angle
        }
        let hands = [hourHand, minHand, secHand]
        for i in 0...2 {
            let denominator: CGFloat = i == 0 ? 12.0 : 60.0
            let value: Int = i == 0 ? currentTime[i] % 12 : currentTime[i]
            let angle = toAngle(value, denominator)
            hands[i].transform = CATransform3DRotate(CATransform3DIdentity, angle, 0, 0, 1)
        }
        
    }
    
    private func setup() {
        
        model.timeSubject
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let err):
                    print("timeSubject error: ", err.localizedDescription)
                case .finished:
                    print("timeSubject finished.")
                }
            }) { time in
                self.currentTime = [time.hour, time.min, time.sec]
                self.animateHands()
        }
        .store(in: &subscriptions)
        
        createOutlinePath()
        createScalePath()
        draw()
        for hand in ClockHand.allCases {
            createHand(hand)
        }
        
        model.start()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHourHand(_:)))
        panGesture.setTranslation(.zero, in: self)
        self.addGestureRecognizer(panGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

}

extension TimePlateView {
    
    func createHand(_ hand: ClockHand) {
        
        var width: CGFloat = 0
        var denominator: CGFloat = 0
        var numerator: CGFloat = 0
        var targetLayer: CAShapeLayer!
        switch hand {
        case .hour:
            width = 3.0
            denominator = 4
            numerator = 11
            targetLayer = hourHand
        case .minute:
            width = 2.0
            denominator = 5
            numerator = 11.5
            targetLayer = minHand
        case .second:
            width = 1.0
            denominator = 7
            numerator = 12
            targetLayer = secHand
        }
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.width / 2, y: bounds.height / denominator))
        path.addLine(to: .init(x: bounds.width / 2, y: bounds.height / 20 * numerator))
        
        targetLayer.frame = bounds
        targetLayer.path = path.cgPath
        targetLayer.fillColor = UIColor.clear.cgColor
        targetLayer.strokeColor = UIColor.white.cgColor
        targetLayer.lineCap = .round
        targetLayer.lineWidth = width
        targetLayer.shadowOpacity = 0.8
        targetLayer.shadowColor = UIColor.black.cgColor
        targetLayer.shadowRadius = 5.0
        targetLayer.shadowOffset = .init(width: 0, height: 2)
        
        layer.addSublayer(targetLayer)
    }
   
    func creatSecHand() {
        let width: CGFloat = 1.0
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.width / 2, y: bounds.height / 7))
        path.addLine(to: .init(x: bounds.width / 2, y: bounds.height / 20 * 12))
        
        secHand.frame = bounds
        secHand.path = path.cgPath
        secHand.fillColor = UIColor.clear.cgColor
        secHand.strokeColor = UIColor.white.cgColor
        secHand.lineCap = .round
        secHand.lineWidth = width
        
        layer.addSublayer(secHand)
        
        secHand.transform = CATransform3DRotate(secHand.transform, .pi * 0.8, 0, 0, 1)
    }
    
    func createOutlinePath() {
        outlinePath = UIBezierPath(ovalIn: bounds).cgPath
    }
    
    func createScalePath() {
        let radius = min(bounds.width, bounds.height) / 2
        let path = UIBezierPath()
        for (i, angle) in stride(from: 0, to: 2 * CGFloat.pi, by: CGFloat.pi / 30).enumerated() {
            let length = i % 5 == 0 ? hourScaleLength : scaleLength
            let x1 = bounds.width / 2 + (radius - outlineWidth - spacing) * sin(angle),
            x2 = bounds.width / 2 + (radius - outlineWidth - spacing - length) * sin(angle)
            let y1 = bounds.height / 2 - (radius - outlineWidth - spacing) * cos(angle),
            y2 = bounds.height / 2 - (radius - outlineWidth - spacing - length) * cos(angle)
            path.move(to: .init(x: x1, y: y1))
            path.addLine(to: .init(x: x2, y: y2))
        }
        scalePath = path.cgPath
    }
    
    func draw() {
        let scaleLayer = CAShapeLayer()
        scaleLayer.frame = bounds
        scaleLayer.path = scalePath
        scaleLayer.lineWidth = scaleWith
        scaleLayer.strokeColor = UIColor.white.cgColor
        scaleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(scaleLayer)
        
        let outlineLayer = CAShapeLayer()
        outlineLayer.frame = bounds
        outlineLayer.path = outlinePath
        outlineLayer.lineWidth = outlineWidth
        outlineLayer.strokeColor = UIColor.white.cgColor
        outlineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(outlineLayer)
    }
    
    
    enum ClockHand: CaseIterable {
        case hour, minute, second
    }
    
}
