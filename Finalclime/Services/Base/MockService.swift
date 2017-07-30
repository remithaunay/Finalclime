//
//  MockService.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

class MockService {

    //Retrieves JSON from .json file contained in the bundle
    func json<T: Decodable>(from fileName: String) -> Observable<T> {
        return Observable.create { observer in
            if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
                do {
                    let data = try NSData(contentsOfFile: path, options: .mappedIfSafe)
                    let value: T = try JSONDecoder().decode(T.self, from: data as Data)
                    observer.onNext(value)
                } catch {
                    observer.onError(error)
                }
            }

            observer.onCompleted()

            return Disposables.create()
        }
    }
}
