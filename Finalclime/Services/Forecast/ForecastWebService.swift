//
//  ForecastWebService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

final class ForecastWebService: WebService, ForecastServicing {
    override var path: String { return "/forecast" }

    func retrieve(id: Int) -> Observable<Forecast> {
        return self.call(method: .get, parameters: weatherMapAPIParameters(with: ["id": id]))
    }
}
