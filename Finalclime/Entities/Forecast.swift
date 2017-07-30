//
//  Forecast.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Decodable

struct Forecast {
    let data: [ForecastData]
}

extension Forecast: Decodable {
    static func decode(_ j: Any) throws -> Forecast {
        return try Forecast(data: j => "list")
    }
}

struct ForecastData: WeatherConditioned, Temperatured {
    let timestamp: Double
    let temperature: Double
    let weatherConditions: [WeatherCondition]
}

extension ForecastData: Decodable {
    static func decode(_ j: Any) throws -> ForecastData {
        return try ForecastData(timestamp: j => "dt",
                                temperature: j => ["main", "temp"],
                                weatherConditions: j => "weather")
    }
}
