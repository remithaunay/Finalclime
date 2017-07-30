//
//  WeatherViewController.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class WeatherViewController: ViewController<WeatherViewModel>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!

    var createTextField: UITextField?

    let collectionItemHeight: Int = 120
    let collectionPadding: Int = 20
    var collectionItemsPerRow: Int {
        switch UIDevice.screen.tuple {
        case (.compact, _):
            return 1
        case (.regular, .portrait):
            return 2
        case (.regular, .landscape):
            return 3
        }
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCell")

        addButton.setTitle("weather.add.button".localized, for: .normal)
        addButton.setTitleColor(UIColor.App.secondary, for: .normal)

        mapButton.setTitle("weather.map.button".localized, for: .normal)
        mapButton.setTitleColor(UIColor.App.secondary, for: .normal)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in }) { _ in
            self.collectionView.reloadData()
        }
    }

    // MARK: ViewModel binding

    override func bindViewModel(_ viewModel: WeatherViewModel) {
        super.bindViewModel(viewModel)

        viewModel.cellModels
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellModels.value.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
                return UICollectionViewCell()
        }

        let cellModel = viewModel.cellModels.value[indexPath.row]
        cell.setup(with: cellModel)

        cell.removeButton.rx.tap
            .subscribe(onNext: { _ in
                guard let indexPath = collectionView.indexPath(for: cell) else { return }
                viewModel.removeCellModel(at: indexPath.row)
            })
            .addDisposableTo(cell.disposeBag)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)

        if let cellModel = viewModel?.cellModels.value[indexPath.row] {
            switch cellModel.state.value {
            case .error(_):
                viewModel?.retrieveWeather(for: cellModel)
            case .data(let weather):
                if let forecastViewController = ViewControllerProvider.forecast {
                    forecastViewController.viewModel?.setup(with: weather)
                    self.navigationController?.pushViewController(forecastViewController, animated: true)
                }
                break
            default:
                break
            }
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = collectionPadding * (collectionItemsPerRow + 1)
        let availableWidth = Int(view.frame.width) - padding
        let widthPerItem = availableWidth / collectionItemsPerRow

        return CGSize(width: widthPerItem, height: collectionItemHeight)
    }

    // MARK: IBActions

    @IBAction func addLocation(_ sender: Any) {
        Alert(title: "weather.add.alert.title".localized, message: "weather.add.alert.message".localized, placeholder: "weather.add.alert.placeholder".localized, delegate: nil) { textfield in
                self.createTextField = textfield
            }
            .addCancel()
            .addOK { _ in
                if let name = self.createTextField?.text {
                    self.viewModel?.add(name: name)
                }
            }.showOn(self)
    }

    @IBAction func openMap(_ sender: Any) {
        if let viewModel = viewModel,
            let navigationViewController = ViewControllerProvider.mapNavigation,
            let mapViewController = navigationViewController.viewControllers.first as? MapViewController {
            mapViewController.viewModel?.setup(with: viewModel)
            self.present(navigationViewController, animated: true, completion: nil)
        }
    }
}
