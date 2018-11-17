//
//  MovieDeatilsVC.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 12/08/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import Kingfisher
import RxSwift

final class MovieDeatilsVC: BaseVC {

    private var model: MovieDetailsVM!

    private let scrollView = UIScrollView()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.add(subviews: posterImageView, movieTitleLabel, movieOverviewLabel, releaseDateView)
        return view
    }()

    private let posterImageView = UIImageView(contentMode: .scaleAspectFill)
    private let movieTitleLabel = UILabel(font: .systemFont(ofSize: 25, weight: .semibold), lines: 1)
    private let movieOverviewLabel = UILabel(font: .systemFont(ofSize: 16, weight: .light))
    private let releaseDateView = MovieYearReleaseView()

    init(movieId: Int64) {
        model = MovieDetailsVM(movieId: movieId)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupViewAndConstraints() {
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)

        if #available(iOS 11.0, *) {
            scrollView.mrk.top(to: view.safeAreaLayoutGuide)
            scrollView.mrk.bottom(to: view.safeAreaLayoutGuide)
        } else {
            scrollView.mrk.top(to: view)
            scrollView.mrk.bottom(to: view)
        }
        scrollView.mrk.leading(to: view)
        scrollView.mrk.trailing(to: view)

        containerView.mrk.top(to: scrollView)
        containerView.mrk.bottom(to: scrollView)
        //It doesn't work
        //containerView.mrk.leading(to: view)
        //containerView.mrk.trailing(to: view)
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true

        posterImageView.mrk.top(to: containerView)
        posterImageView.mrk.leading(to: containerView)
        posterImageView.mrk.trailing(to: containerView)
        posterImageView.mrk.height(562.5)

        movieTitleLabel.mrk.top(to: posterImageView, attribute: .bottom, relation: .equal, constant: 8.5)
        movieTitleLabel.mrk.leading(to: containerView, attribute: .leading, relation: .equal, constant: 13)
        movieTitleLabel.mrk.trailing(to: containerView, attribute: .trailing, relation: .equal, constant: -13)

        movieOverviewLabel.mrk.top(to: movieTitleLabel, attribute: .bottom, relation: .equal, constant: 5)
        movieOverviewLabel.mrk.leading(to: movieTitleLabel)
        movieOverviewLabel.mrk.trailing(to: movieTitleLabel)

        releaseDateView.mrk.top(to: movieOverviewLabel, attribute: .bottom, relation: .equal, constant: 12)
        releaseDateView.mrk.leading(to: containerView, attribute: .leading, relation: .equal, constant: 13)
        releaseDateView.mrk.bottom(to: containerView, attribute: .bottom, relation: .equal, constant: -12)
    }

    override func bind() {
        model.inProgress
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        model.movieData
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] movie in
                guard let `self` = self else { return }

                self.title = movie.title

                if let path = movie.posterPath, let imageBaseUrl = URL(string: Config.URL.basePoster) {
                    let posterPath = imageBaseUrl
                        .appendingPathComponent("w780")
                        .appendingPathComponent(path)

                    self.posterImageView.kf.indicatorType = .activity
                    self.posterImageView.kf.setImage(
                        with: posterPath,
                        options: [.transition(.fade(0.2))]
                    )
                }

                self.movieTitleLabel.text = movie.title
                self.movieOverviewLabel.text = movie.overview
                self.releaseDateView.setupWith(date: movie.releaseDate)
            }).disposed(by: disposeBag)
    }
}
