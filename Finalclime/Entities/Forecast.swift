//
//  Forecast.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

struct Forecast {
    let data: [ForecastData]

    enum CodingKeys: String, CodingKey {
        case date = "list"
    }
}

extension Forecast: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode([ForecastData].self, forKey: .date)
    }
}

struct ForecastData: WeatherConditioned, Temperatured, Decodable {
    let timestamp: Double
    let main: WeatherMain
    let weatherConditions: [WeatherCondition]

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case main = "main"
        case weatherConditions = "weather"
    }
}
