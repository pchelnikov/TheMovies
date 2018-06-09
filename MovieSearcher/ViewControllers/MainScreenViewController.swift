//
//  MainScreenViewController.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 08/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class MainScreenViewController: UIViewController {
    
    private let model = MainScreenViewModel()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Search It!", for: .normal)
        return button
    }()
    
    private var dBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        bind()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        view.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        searchButton.mrk.center(to: view)
    }
    
    private func bind() {
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.model.getMovies()
            }).disposed(by: dBag)
    }
}

