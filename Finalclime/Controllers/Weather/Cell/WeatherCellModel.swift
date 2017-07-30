//
//  WeatherCollectionCellModel.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

enum WeatherCellModelState {
    case loading
    case data(Weather)
    case error(Error)
}

struct WeatherCellModel {
    let cityName: String
    var state = Variable<WeatherCellModelState>(.loading)

    init(cityName: String) {
        self.cityName = cityName
    }
}
