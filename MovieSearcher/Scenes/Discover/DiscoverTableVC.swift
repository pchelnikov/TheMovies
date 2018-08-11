//
//  DiscoverTableVC.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import RxCocoa

final class DiscoverTableVC: BaseTableVC {

    private let model = DiscoverVM()

    private lazy var tableRefreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return rc
    }()

    override func setupViewAndConstraints() {
        navigationItem.title = "The Movie DB"

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
        }

        setupTableView()
    }

    private func setupTableView() {
        refreshControl = tableRefreshControl

        tableView.separatorStyle     = .singleLine
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.tableFooterView    = UIView()

        tableView.register(MovieItemCell.self, forCellReuseIdentifier: Config.CellIdentifier.MovieTable.movieCell)
    }

    override func bind() {
        tableRefreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] in self?.model.refreshData.onNext(()) })
            .disposed(by: disposeBag)

        //refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

     // Configure the cell...

     return cell
     }
     */
}
