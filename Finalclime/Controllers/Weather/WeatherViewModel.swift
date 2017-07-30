//
//  WeatherViewModel.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

struct WeatherViewModelInputs {
    let weather: WeatherServicing
    let storing: StoringServicing
}

final class WeatherViewModel: ViewModel<WeatherViewModelInputs> {

    var cellModels = Variable<[WeatherCellModel]>([])

    override init(inputs: WeatherViewModelInputs) {
        super.init(inputs: inputs)

        if let cities = inputs.storing.retrieveCities() {
            cellModels.value = cities.map({WeatherCellModel(cityName: $0)})
            for cellModel in cellModels.value {
                self.retrieveWeather(for: cellModel)
            }
        }
    }

    // MARK: Available methods

    func retrieveWeather(for cellModel: WeatherCellModel) {
        cellModel.state.value = .loading

        inputs.weather.retrieve(name: cellModel.cityName)
            .subscribe({ event in
                switch event {
                case .next(let weather):
                    cellModel.state.value = .data(weather)
                case .error(let error):
                    cellModel.state.value = .error(error)
                case .completed:
                    break
                }
            }).addDisposableTo(disposeBag)
    }

    func removeCellModel(at row: Int) {
        cellModels.value.remove(at: row)
        self.storeCities()
    }

    func add(name: String) {
        let cellModel = WeatherCellModel(cityName: name)
        cellModels.value.append(cellModel)
        self.retrieveWeather(for: cellModel)
        self.storeCities()
    }

    // MARK: Internal methods

    private func storeCities() {
        inputs.storing.store(cities: cellModels.value.map({$0.cityName}))
    }
}
