//
//  BaseTableVC.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import MarkerKit
import RxSwift

class BaseTableVC: UITableViewController {

    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViewAndConstraints()
        bind()

        view.addSubview(activityIndicatorView)

        activityIndicatorView.mrk.centerX(to: view)
        activityIndicatorView.mrk.centerY(to: view, relation: .equal, constant: -100)
    }

    func setupViewAndConstraints() {

    }

    func bind() {
        
    }

    final func showError(message: String) {
        showAlertController(self, title: "Error", message: message, style: .one("Ok"), handler: nil)
    }

    final func isCanLoadNextData(for scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y

        if scrollView.contentSize.height < scrollView.frame.size.height {
            return false
        }

        let maiximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maiximumOffset - currentOffset

        if deltaOffset <= 350 {
            return true
        }

        return false
    }
}
