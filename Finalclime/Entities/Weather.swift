//
//  Weather.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Decodable

protocol Temperatured {
    var temperature: Double { get }
    var formattedTemperature: String { get }
}

extension Temperatured {
    var formattedTemperature: String {
        return String(format: "temperature.format".localized, Int(temperature))
    }
}

struct Weather: WeatherConditioned, Temperatured {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let temperature: Double
    let windSpeed: Double
    let weatherConditions: [WeatherCondition]
}

extension Weather: Decodable {
    static func decode(_ j: Any) throws -> Weather {
        return try Weather(id: j => "id",
                        name: j => "name",
                        latitude: j => ["coord", "lat"],
                        longitude: j => ["coord", "lon"],
                        temperature: j => ["main", "temp"],
                        windSpeed: j => ["wind", "speed"],
                        weatherConditions: j => "weather")
    }
}
