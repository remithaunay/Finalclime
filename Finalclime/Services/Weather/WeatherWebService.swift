//
//  WeatherWebService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

final class WeatherWebService: WebService, WeatherServicing {
    override var path: String { return "/weather" }

    func retrieve(name: String) -> Observable<Weather> {
        return self.call(method: .get, parameters: weatherMapAPIParameters(with: ["q": name]))
    }
}
