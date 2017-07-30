//
//  EnvironmentViewController.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit

final class EnvironmentViewController: ViewController<EnvironmentViewModel> {

    @IBOutlet weak var mockButton: UIButton!
    @IBOutlet weak var webButton: UIButton!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.setup(mockButton, title: "environment.mock.button".localized)
        self.setup(webButton, title: "environment.web.button".localized)
    }

    // MARK: Internal methods

    private func goToWeather() {
        if let weatherViewController = ViewControllerProvider.weather {
            self.navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }

    private func setup(_ button: UIButton, title: String) {
        button.layer.cornerRadius = mockButton.frame.size.width / 2
        button.backgroundColor = UIColor.App.secondary
        button.setTitleColor(UIColor.App.main, for: .normal)
        button.setTitle(title, for: .normal)
    }

    // MARK: IBActions

    @IBAction func useMock(_ sender: Any) {
        Configuration.isMockEnable = true
        goToWeather()
    }

    @IBAction func useWeb(_ sender: Any) {
        goToWeather()
    }
}
