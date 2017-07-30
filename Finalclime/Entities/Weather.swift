//
//  Weather.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

protocol Temperatured {
    var main: WeatherMain { get }
    var formattedTemperature: String { get }
}

extension Temperatured {
    var formattedTemperature: String {
        return String(format: "temperature.format".localized, Int(main.temperature))
    }
}

struct Weather: WeatherConditioned, Temperatured, Decodable {
    let id: Int
    let name: String
    let coordinates: Coordinates
    let main: WeatherMain
    let wind: WeatherWind
    let weatherConditions: [WeatherCondition]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinates = "coord"
        case main
        case wind
        case weatherConditions = "weather"
    }
}

struct WeatherWind: Decodable {
    let speed: Double
}
