//
//  UIColor+Extension.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }

    convenience init(hex: Int, alpha: Double) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255, green: CGFloat((hex >> 8) & 0xff) / 255, blue: CGFloat(hex & 0xff) / 255, alpha: CGFloat(alpha))
    }

    //This struct contains the application theme
    struct App {
        static var main = UIColor(hex: 0x3498DB)
        static var secondary = UIColor.white
        static var header = UIColor(hex: 0xE74C3C)
        static var body = UIColor(hex: 0x2C3E50)
    }
}
