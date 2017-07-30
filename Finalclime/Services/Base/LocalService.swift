//
//  LocalService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

class LocalService {

    let userDefaults = UserDefaults.standard

    func save(_ key: String, value: Any) -> Bool {
        userDefaults.set(value, forKey: key)
        return true
    }

    func load(_ key: String) -> Any? {
        return userDefaults.object(forKey: key)
    }
}
