//
//  Coordinates.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 30/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
