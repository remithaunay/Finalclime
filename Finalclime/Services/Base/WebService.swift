//
//  WebService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class WebService {

    var baseURL: String { return "http://api.openweathermap.org/data/2.5" }
    var path: String { return "" }

    func weatherMapAPIParameters(with parameters: [String:Any]) -> [String:Any] {
        var parameters = parameters
        parameters["appid"] = "a563f100e0eba0db9c584320135b2360"
        parameters["units"] = "metric"

        return parameters
    }

    func call<T: Decodable>(method: HTTPMethod = .get, parameters: [String: Any]? = nil) -> Observable<T> {
        return Observable.create { observer in

            Alamofire.request("\(self.baseURL)\(self.path)", method: method, parameters: parameters).responseData { response in

                guard let data = response.result.value else {
                    observer.onError(response.error!)
                    observer.onCompleted()
                    return
                }

                do {
                    let value: T = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(value)
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
