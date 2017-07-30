//
//  MapViewModel.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

struct MapViewModelInputs {
    init() {}
}

final class MapViewModel: ViewModel<MapViewModelInputs> {

    var weathers = Variable<[Weather]>([])

    func setup(with weatherViewModel: WeatherViewModel) {
        weathers.value = weatherViewModel.cellModels.value.flatMap({
            switch $0.state.value {
            case .data(let weather):
                return weather
            default:
                return nil
            }
        })
    }
}
