//
//  ViewModel.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelling {
    var error: Variable<Error?> { get }
    var isLoading: Variable<Bool?> { get }
}

class ViewModel<T>: NSObject, ViewModelling {
    let inputs: T
    let disposeBag = DisposeBag()

    let error = Variable<Error?>(nil)
    let isLoading = Variable<Bool?>(nil)

    init(inputs: T) {
        self.inputs = inputs
    }

    // MARK: Event handling

    func handleEvent<R>(_ event: Event<R>, dataHandler: (R) -> Void) {
        switch event {
        case .next(let response):
            dataHandler(response)
        case .error(let error):
            handleError(error)
        case .completed:
            break
        }
    }

    func handleError(_ error: Error) {
        self.error.value = error
    }
}
