//
//  ForecastCell.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit

final class ForecastCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        weatherImageView.tintColor = UIColor.App.body
    }

    func setup(with cellModel: ForecastCellModel) {
        dateLabel.text = cellModel.formattedDate
        temperatureLabel.text = cellModel.formattedTemperature
        weatherImageView.image = UIImage(named: cellModel.imageName)
    }
}
