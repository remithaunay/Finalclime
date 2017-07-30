//
//  WeatherAnnotation.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import MapKit

final class WeatherAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let iconName: String

    init(_ weather: Weather) {
        self.title = weather.name
        self.subtitle = weather.formattedTemperature
        self.coordinate = CLLocationCoordinate2D(latitude: weather.coordinates.latitude, longitude: weather.coordinates.longitude)
        self.iconName = weather.iconName
    }
}
