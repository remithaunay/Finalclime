//
//  MapAssembly.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import Swinject

final class MapAssembly: Assembly {
    init() {}

    func assemble(container: Container) {
        container.register(MapViewModel.self) { _ in
            return MapViewModel(inputs: MapViewModelInputs())
        }
    }
}
