//
//  ViewController.swift
//  Finalclime
//
//  Created by Rémi Thaunay on 29/07/2017.
//  Copyright © 2017 Rémi Thaunay. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class ViewController<T: ViewModelling>: UIViewController {
    var viewModel: T?

    lazy var disposeBag = DisposeBag()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.App.main

        if let viewModel = self.viewModel {
            self.bindViewModel(viewModel)
            self.bindLoading(viewModel)
            self.bindError(viewModel)
        }
    }

    // MARK: ViewModel binding

    func bindViewModel(_ viewModel: T) {}

    func bindLoading(_ viewModel: T) {
        viewModel.isLoading
            .asDriver()
            .filter { $0 != nil }
            .drive(onNext: { isLoading in
                self.handleLoading(isLoading!)
            })
            .addDisposableTo(disposeBag)
    }

    func bindError(_ viewModel: T) {
        viewModel.error
            .asDriver()
            .filter { $0 != nil }
            .drive(onNext: { error in
                self.handleError(error!)
            })
            .addDisposableTo(disposeBag)
    }

    // MARK: UI methods

    func handleError(_ error: Error) {}

    func handleLoading(_ isLoading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
    }
}
