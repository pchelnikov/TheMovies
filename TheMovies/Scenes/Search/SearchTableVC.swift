//
//  SearchTableVC.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 08/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class SearchTableVC: BaseTableVC {
    
    private let model = SearchScreenVM()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var emptyDataLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 14), alignment: .center)
        label.text = "Please type something and tap Search"
        return label
    }()
    
    private var isSearchBarActive = false

    override func setupViewAndConstraints() {
        super.setupViewAndConstraints()

        navigationItem.title = "Search"

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
        }

        view.add(subviews: emptyDataLabel)

        setupSearchController()
        setupConstraints()
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.register(MovieItemCell.self, forCellReuseIdentifier: Config.CellIdentifier.MovieTable.movieCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Config.CellIdentifier.MovieTable.historyCell)
    }
    
    private func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        
        definesPresentationContext = true
        
        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            searchController.searchBar.backgroundColor = .white
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    private func setupConstraints() {
        emptyDataLabel.mrk.centerX(to: view)
        emptyDataLabel.mrk.centerY(to: view, relation: .equal, constant: -100)
        emptyDataLabel.mrk.leading(to: view, attribute: .leading, relation: .equal, constant: 20)
        emptyDataLabel.mrk.trailing(to: view, attribute: .trailing, relation: .equal, constant: -20)
    }
    
    override func bind() {
        model.inProgress
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        model.dataRefreshed
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEmptyData in
                guard let `self` = self else { return }
                self.emptyDataLabel.isHidden = !isEmptyData
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        model.onError
            .subscribe(onNext: { [weak self] message in self?.showError(message: message) })
            .disposed(by: disposeBag)
    }
    
    private func tapToSearchMovies(for query: String) {
        searchController.isActive = false
        model.lastQuery = query
        model.loadNextData.onNext(.fromStart)
    }
    
    // MARK: - UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSearchBarActive && !model.isPageLoading.value && !model.endOfData.value else { return }
        
        if isCanLoadNextData(for: scrollView) {
            loadNextData()
        }
    }
    
    private func loadNextData() {
        model.loadNextData.onNext(.continueLoading)
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarActive {
            return model.queriesHistory.count
        } else {
            return model.movies.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearchBarActive {
            return 44
        } else {
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearchBarActive {
            let cell = tableView.dequeueReusableCell(withIdentifier: Config.CellIdentifier.MovieTable.historyCell, for: indexPath)
            if let historyItem = model.historicalQuery(at: indexPath) {
                cell.textLabel?.text = historyItem
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Config.CellIdentifier.MovieTable.movieCell, for: indexPath) as! MovieItemCell
            if let movieItem = model.movieItem(at: indexPath) {
                cell.setup(with: movieItem)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchBarActive {
            guard let query = model.historicalQuery(at: indexPath) else { return }
            tapToSearchMovies(for: query)
        } else {
            guard let movieItem = model.movieItem(at: indexPath), let id = movieItem.id else {
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            let controller = MovieDeatilsVC(movieId: id)
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchTableVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        emptyDataLabel.isHidden = true
        isSearchBarActive = true
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        emptyDataLabel.isHidden = false
        isSearchBarActive = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchController.searchBar.text {
            tapToSearchMovies(for: searchString)
        }
    }
}
