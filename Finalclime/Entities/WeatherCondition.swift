//
//  WeatherConditions.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

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

struct WeatherCondition: Decodable {
    let icon: String
}
