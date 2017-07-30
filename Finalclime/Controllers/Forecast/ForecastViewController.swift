//
//  ForecastViewController.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ForecastViewController: ViewController<ForecastViewModel>, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "forecast.title".localized
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        tableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: "ForecastCell")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: ViewModel binding

    override func bindViewModel(_ viewModel: ForecastViewModel) {
        super.bindViewModel(viewModel)

        viewModel.cellModels
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)

        viewModel.isLoading
            .asDriver()
            .filter({$0 != nil})
            .drive(onNext: { [weak self] isLoading in
            self?.activityIndicator.isHidden = !isLoading!
            self?.tableView.isHidden = isLoading!
        })
            .addDisposableTo(disposeBag)
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellModels.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellModel = viewModel?.cellModels.value[indexPath.row],
            let cell: ForecastCell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCell {
            cell.setup(with: cellModel)
            return cell
        }

        return UITableViewCell()
    }
}
