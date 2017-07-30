//
//  WeatherAssembly.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Swinject

final class WeatherAssembly: Assembly {
    init() {}

    func assemble(container: Container) {
        container.register(WeatherViewModel.self) { _ in
            return WeatherViewModel(inputs: WeatherViewModelInputs(weather: Configuration.isMockEnable ? WeatherMockService() : WeatherWebService(), storing: StoringLocalService()))
        }
    }
}
