//
//  EnvironmentAssembly.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Swinject

final class EnvironmentAssembly: Assembly {
    init() {}

    func assemble(container: Container) {
        container.register(EnvironmentViewModel.self) { _ in
            return EnvironmentViewModel(inputs: EnvironmentViewModelInputs())
        }
    }
}
