//
//  WeatherCollectionViewCell.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class WeatherCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var removeButton: UIButton!

    var disposeBag: DisposeBag = DisposeBag()

    // MARK: Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.App.main
        nameLabel.textColor = UIColor.App.header
        imageView.tintColor = UIColor.App.header
        temperatureLabel.textColor = UIColor.App.body
        windLabel.textColor = UIColor.App.body
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath.cgPath
    }

    // MARK: Available methods

    func setup(with cellModel: WeatherCellModel) {
        nameLabel.text = cellModel.cityName

        cellModel.state
            .asDriver()
            .drive(onNext: { [weak self] state in
                self?.setup(with: state)
            })
            .addDisposableTo(disposeBag)
    }

    // MARK: Internal methods

    private func setup(with state: WeatherCellModelState) {
        activityIndicator.isHidden = true
        temperatureLabel.isHidden = true
        windLabel.isHidden = true
        imageView.isHidden = true

        switch state {
        case .loading:
            activityIndicator.isHidden = false
        case .error(_):
            imageView.isHidden = false
            imageView.image = #imageLiteral(resourceName: "icon-reload")
        case .data(let weather):
            setup(with: weather)
        }
    }

    private func setup(with weather: Weather) {
        temperatureLabel.isHidden = false
        windLabel.isHidden = false
        imageView.isHidden = false

        imageView.image = UIImage(named: weather.iconName)

        nameLabel.text = weather.name
        temperatureLabel.text = weather.formattedTemperature
        windLabel.text = "\(Int(weather.wind.speed * 3.6)) km/h"
    }
}
