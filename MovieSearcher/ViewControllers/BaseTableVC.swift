//
//  BaseTableVC.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableVC: UITableViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupViewAndConstraints()
        bind()
    }

    func setupViewAndConstraints() {

    }

    func bind() {
        
    }
}
