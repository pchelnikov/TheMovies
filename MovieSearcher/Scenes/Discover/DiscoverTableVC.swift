//
//  DiscoverTableVC.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 05/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class DiscoverTableVC: BaseTableVC {

    private let model = DiscoverVM()

    private lazy var tableRefreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return rc
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    override func setupViewAndConstraints() {
        navigationItem.title = "The Movies"
    }

    override func setupTableView() {
        super.setupTableView()
        refreshControl = tableRefreshControl
        tableView.register(MovieItemCell.self, forCellReuseIdentifier: Config.CellIdentifier.MovieTable.movieCell)
    }

    override func bind() {
        model.inProgress
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        tableRefreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] in self?.model.loadNextData.onNext(.fromStart) })
            .disposed(by: disposeBag)

        model.dataRefreshed
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }).disposed(by: disposeBag)

        model.onError
            .subscribe(onNext: { [weak self] message in self?.showError(message: message) })
            .disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.movies.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Config.CellIdentifier.MovieTable.movieCell, for: indexPath) as! MovieItemCell
        if let movieItem = model.movieItem(at: indexPath) {
            cell.setup(with: movieItem)
        }
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieItem = model.movieItem(at: indexPath), let id = movieItem.id else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let controller = MovieDeatilsVC(movieId: id)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !model.isPageLoading.value && !model.endOfData.value else { return }

        if isCanLoadNextData(for: scrollView) {
            loadNextData()
        }
    }

    private func loadNextData() {
        model.loadNextData.onNext(.continueLoading)
    }
}
