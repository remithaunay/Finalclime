//
//  UIDevice+Extension.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit

//These struct, enums and extension allow us to know the current screen configuration
struct ScreenOptions {
    let size: UIInterfaceSize
    let orientation: UIInterfaceOrientation

    var tuple: (size: UIInterfaceSize, orientation: UIInterfaceOrientation) {
        return (self.size, self.orientation)
    }
}

enum UIInterfaceSize {
    case compact
    case regular
}

enum UIInterfaceOrientation {
    case portrait
    case landscape
}

extension UIDevice {
    static var screen: ScreenOptions {
        let screenFrame = UIScreen.main.bounds
        guard let frame = UIApplication.shared.keyWindow?.frame else {
            return ScreenOptions(size: .compact, orientation: .portrait)
        }

        switch (screenFrame.width < screenFrame.height, UIDevice.current.userInterfaceIdiom, Int(frame.width), Int(screenFrame.width)) {
        case (true, .phone, _, _):
            return ScreenOptions(size: .compact, orientation: .portrait)
        case (false, .phone, _, _):
            return ScreenOptions(size: .compact, orientation: .landscape)
        case let (true, .pad, width, screenWidth) where width  < screenWidth: //iPad portrait multitasking
            return ScreenOptions(size: .compact, orientation: .portrait)
        case let (false, .pad, width, screenWidth) where width  <= screenWidth / 2: //iPad landscape multitasking
            return ScreenOptions(size: .compact, orientation: .portrait)
        case let (false, .pad, width, screenWidth) where width < screenWidth && width > screenWidth / 2: //iPad landscape multitasking
            return ScreenOptions(size: .regular, orientation: .portrait)
        case (true, .pad, _, _):
            return ScreenOptions(size: .regular, orientation: .portrait)
        default:
            return ScreenOptions(size: .regular, orientation: .landscape)
        }
    }
}
