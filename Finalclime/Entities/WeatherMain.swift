//
//  WeatherMain.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 30/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

struct WeatherMain: Decodable {
    let temperature: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
