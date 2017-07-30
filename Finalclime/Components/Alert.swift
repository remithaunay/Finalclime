//
//  Alert.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit

//This struct wraps an UIAlertController to simplify its usage
struct Alert {

    let alertController: UIAlertController

    init(title: String?, message: String?) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    init(title: String?, message: String?, placeholder: String?, delegate: UITextFieldDelegate?, handler: @escaping (UITextField) -> Void) {
        self.init(title: title, message: message)

        alertController.addTextField { (textField) -> Void in
            textField.clearButtonMode = .always
            textField.delegate = delegate
            textField.placeholder = placeholder
            handler(textField)
        }
    }

    @discardableResult func addAction(_ title: String, style: UIAlertActionStyle = .default, _ handler: ((UIAlertAction) -> Void)? = nil) -> Alert {
        alertController.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }

    @discardableResult func addOK(_ handler: ((UIAlertAction) -> Void)? = nil) -> Alert {
        return self.addAction("common.ok".localized, style: .default, handler)
    }

    @discardableResult func addCancel() -> Alert {
        return self.addAction("common.cancel".localized, style: .cancel)
    }

    func showOn(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.present(alertController, animated: true, completion: completion)
    }

}
