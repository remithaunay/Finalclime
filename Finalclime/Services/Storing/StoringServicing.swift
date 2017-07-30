//
//  StoringServicing.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

protocol StoringServicing {
    @discardableResult func store(cities: [String]) -> Bool
    func retrieveCities() -> [String]?
}
