//
//  WeatherConditions.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Decodable

protocol WeatherConditioned {
    var weatherConditions: [WeatherCondition] { get }
    var iconName: String { get }
}

extension WeatherConditioned {
    var iconName: String {
        guard let icon = weatherConditions.first?.icon else {
            return ""
        }
        return "icon-weather-\(icon)"
    }
}

struct WeatherCondition {
    let icon: String
}

extension WeatherCondition: Decodable {
    static func decode(_ j: Any) throws -> WeatherCondition {
        return try WeatherCondition(icon: j => "icon")
    }
}
