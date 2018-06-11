//
//  MainScreenTableViewController.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 08/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class MainScreenTableViewController: UITableViewController {
    
    private let model = MainScreenViewModel()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var emptyDataLabel: UILabel = {
        let label = Label.custom(UIFont.systemFont(ofSize: 14), color: .black, lines: 0, alignment: .center)
        label.text = "Please type something and tap Search"
        return label
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }()
    
    private var isSearchBarActive = false
    
    private var dBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        bind()
    }
    
    private func setupViews() {
        title = "Movies"
        
        view.backgroundColor = .white
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        setupTableView()
        setupSearchController()
        
        view.addSubview(emptyDataLabel)
        view.addSubview(activityIndicatorView)
    }
    
    private func setupTableView() {
        tableView.separatorStyle     = .none
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.tableFooterView    = UIView()
        
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
        
        activityIndicatorView.mrk.centerX(to: view)
        activityIndicatorView.mrk.centerY(to: view, relation: .equal, constant: -100)
    }
    
    private func bind() {
        model.inProgress
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: dBag)
        
        model.dataRefreshed
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEmptyData in
                guard let `self` = self else { return }
                self.emptyDataLabel.isHidden = !isEmptyData
                self.tableView.reloadData()
            }).disposed(by: dBag)        
    }
    
    private func tapToSearchMovies(for query: String) {
        searchController.isActive = false
        model.getMovies(for: query)
    }

    // MARK: UITableViewDelegate, UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarActive {
            return model.queriesHistory.count
        } else {
            return model.rowsCount
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
        }
    }
}

extension MainScreenTableViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        emptyDataLabel.isHidden = true
        isSearchBarActive = true
        tableView.reloadData()
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        emptyDataLabel.isHidden = false
        isSearchBarActive = false
        tableView.reloadData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchController.searchBar.text {
            tapToSearchMovies(for: searchString)
        }
    }
}
