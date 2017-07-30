//
//  ForecastAssembly.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Swinject

final class ForecastAssembly: Assembly {
    init() {}

    func assemble(container: Container) {
        container.register(ForecastViewModel.self) { _ in
            return ForecastViewModel(inputs: ForecastViewModelInputs(forecast: Configuration.isMockEnable ? ForecastMockService() : ForecastWebService()))
        }
    }
}
