//
//  PresetColors.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/25.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class PresetColors {
    
    static let level1: UIColor = hex("1a1a2e")!
    static let level2: UIColor = hex("16213e")!
    static let level3: UIColor = hex("0f3460")!
    static let level4: UIColor = hex("e94560")!
    
    class func hex(_ colorStr: String, _ alpha: CGFloat? = nil) -> UIColor? {
        var values: [CGFloat] = Array(repeating: 0, count: 6)
        for (i, c) in colorStr.reversed().enumerated() {
            if let val = hex2float(c, CGFloat(i%2)), i < 6 {
                values[i] = val
            } else {
                break
            }
        }
        let result = UIColor(red: (values[4]+values[5])/255, green: (values[2]+values[3])/255, blue: (values[0]+values[1])/255, alpha: alpha ?? 1.0)
        return result
    }
    
    class func hex2float(_ c: Character, _ power: CGFloat) -> CGFloat? {
        var someValue: UInt8?
        if let ascii = c.asciiValue {
            if 48 <= ascii && ascii <= 57 {
                someValue = ascii - 48
            }
            if c.isLowercase {
                someValue = ascii - 87
            }
            if c.isUppercase {
                someValue = ascii - 55
            }
        }
        guard let value = someValue else {
            return nil
        }
        return CGFloat(value) * pow(16, power)
    }

}
