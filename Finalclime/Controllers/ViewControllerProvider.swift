//
//  ViewControllerProvider.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit
import Swinject

//This struct allows us to quickly retrieve the controllers
struct ViewControllerProvider {

    private static let container = Container()
    private static let mainStoryboard = UIStoryboard.named("Main")

    static var mainNavigation: UINavigationController? {
        guard let environmentViewController = mainStoryboard.instantiate(EnvironmentViewController.self) else {
            return nil
        }

        let assembler = Assembler([EnvironmentAssembly()], container: container)
        environmentViewController.viewModel = assembler.resolver.resolve(EnvironmentViewModel.self)

        return UINavigationController(rootViewController: environmentViewController)
    }

    static var weather: WeatherViewController? {
        guard let weatherViewController = mainStoryboard.instantiate(WeatherViewController.self) else {
            return nil
        }

        let assembler = Assembler([WeatherAssembly()], container: container)
        weatherViewController.viewModel = assembler.resolver.resolve(WeatherViewModel.self)

        return weatherViewController
    }

    static var mapNavigation: UINavigationController? {
        guard let mapViewController = mainStoryboard.instantiate(MapViewController.self) else {
            return nil
        }

        let assembler = Assembler([MapAssembly()], container: container)
        mapViewController.viewModel = assembler.resolver.resolve(MapViewModel.self)

        return UINavigationController(rootViewController: mapViewController)
    }

    static var forecast: ForecastViewController? {
        guard let forecastViewController = mainStoryboard.instantiate(ForecastViewController.self) else {
            return nil
        }

        let assembler = Assembler([ForecastAssembly()], container: container)
        forecastViewController.viewModel = assembler.resolver.resolve(ForecastViewModel.self)

        return forecastViewController
    }
}
