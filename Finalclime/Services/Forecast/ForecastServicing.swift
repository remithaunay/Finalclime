//
//  ForecastServicing.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

protocol ForecastServicing {
    func retrieve(id: Int) -> Observable<Forecast>
}
