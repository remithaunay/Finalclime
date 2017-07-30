//
//  ForecastMockService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

final class ForecastMockService: MockService, ForecastServicing {
    func retrieve(id: Int) -> Observable<Forecast> {
        return json(from: "forecast")
    }
}
