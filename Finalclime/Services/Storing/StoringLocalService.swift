//
//  StoringLocalService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

final class StoringLocalService: LocalService, StoringServicing {
    let citiesKey: String = "storage.cities"

    func store(cities: [String]) -> Bool {
        return save(citiesKey, value: cities)
    }

    func retrieveCities() -> [String]? {
        return load(citiesKey) as? [String]
    }
}
