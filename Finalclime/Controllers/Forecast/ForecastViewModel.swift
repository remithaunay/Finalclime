//
//  ForecastViewModel.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

struct ForecastViewModelInputs {
    let forecast: ForecastServicing
}

final class ForecastViewModel: ViewModel<ForecastViewModelInputs> {

    private var weather: Weather?

    let cellModels = Variable<[ForecastCellModel]>([])

    func setup(with weather: Weather) {
        self.weather = weather

        self.isLoading.value = true
        inputs.forecast.retrieve(id: weather.id)
            .subscribe({ event in
                self.isLoading.value = false
                self.handleEvent(event, dataHandler: { forecast in
                    self.prepareData(with: forecast)
                })
            }).addDisposableTo(disposeBag)
    }

    // MARK: Internal methods

    private func prepareData(with forecast: Forecast) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E. HH:mm"

        var cellModels: [ForecastCellModel] = []
        forecast.data.forEach { data in
            let formattedDate = dateFormatter.string(from: Date(timeIntervalSince1970: data.timestamp))
            cellModels.append(ForecastCellModel(formattedDate: formattedDate, formattedTemperature: data.formattedTemperature, imageName: data.iconName))
        }
        self.cellModels.value = cellModels
    }
}
