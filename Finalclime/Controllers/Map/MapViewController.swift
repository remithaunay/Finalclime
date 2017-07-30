//
//  MapViewController.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

final class MapViewController: ViewController<MapViewModel>, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "map.title".localized
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissMap))
    }

    // MARK: ViewModel binding

    override func bindViewModel(_ viewModel: MapViewModel) {
        super.bindViewModel(viewModel)

        viewModel.weathers
            .asDriver()
            .drive(onNext: { [weak self] weathers in
                if let weakSelf = self {
                    weakSelf.createAnnotations(for: weathers)
                    weakSelf.mapView.showAnnotations(weakSelf.mapView.annotations, animated: true)
                }
            })
            .addDisposableTo(disposeBag)
    }

    // MARK: MKMapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "WeatherAnnotationView")

        if let weatherAnnotation = annotation as? WeatherAnnotation {
            view.image = UIImage(named: weatherAnnotation.iconName)
            view.tintColor = UIColor.App.secondary
            view.canShowCallout = true
            view.layer.cornerRadius = (view.image?.size.width)! / 2
        }

        return view
    }

    // MARK: Internal methods

    @objc func dismissMap() {
        self.dismiss(animated: true, completion: nil)
    }

    private func createAnnotations(for weathers: [Weather]) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        for weather in weathers {
            self.mapView.addAnnotation(WeatherAnnotation(weather))
        }
    }
}
