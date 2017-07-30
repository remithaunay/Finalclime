//
//  UIStoryboard+Extension.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static func named(_ name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }

    func instantiate<T: UIViewController>(_ viewControllerType: T.Type) -> T? {
        let className = String(describing: viewControllerType)

        return instantiateViewController(withIdentifier: className) as? T
    }
}
