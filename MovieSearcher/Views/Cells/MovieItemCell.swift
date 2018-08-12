//
//  MovieItemCell.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

import Kingfisher
import MarkerKit

class MovieItemCell: UITableViewCell {
    
    private struct Sizes {
        static let posterDefaultWidth: CGFloat = 125
        static let posterDefaultHeight: CGFloat = 188
    }
    
    private let posterImageView = UIImageView(contentMode: .scaleAspectFill)
    private let movieTitleLabel = UILabel(font: .systemFont(ofSize: 17, weight: .semibold), lines: 1)
    private let disclosureImageView = UIImageView(image: Image.by(assetId: .disclosureIndicator))
    private let movieOverviewLabel = UILabel(font: .systemFont(ofSize: 14, weight: .light))
    private let releaseDateView = MovieYearReleaseView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.add(subviews: posterImageView, movieTitleLabel, disclosureImageView,
                        movieOverviewLabel, releaseDateView)
    }
    
    private func setupConstraints() {
        //TODO: fix the constraints
        posterImageView.mrk.top(to: contentView, attribute: .top, relation: .equal, constant: 5)
        posterImageView.mrk.leading(to: contentView, attribute: .leading, relation: .equal, constant: 0)
        posterImageView.mrk.width(Sizes.posterDefaultWidth)
        posterImageView.mrk.height(Sizes.posterDefaultHeight)
        //posterImageView.mrk.bottom(to: contentView, attribute: .bottom, relation: .lessThanOrEqual, constant: -7)
        posterImageView.mrk.bottom(to: contentView, attribute: .bottom, relation: .equal, constant: -7)
        
        posterImageView.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
        
        movieTitleLabel.mrk.top(to: contentView, attribute: .top, relation: .equal, constant: 6)
        movieTitleLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 12)
        movieTitleLabel.mrk.trailing(to: disclosureImageView, attribute: .leading, relation: .equal, constant: -13)

        disclosureImageView.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -19)
        disclosureImageView.mrk.width(8)
        disclosureImageView.mrk.centerY(to: movieTitleLabel)
        
        movieOverviewLabel.mrk.top(to: movieTitleLabel, attribute: .bottom, relation: .equal, constant: 7)
        movieOverviewLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 12)
        movieOverviewLabel.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -19)
        //movieOverviewLabel.mrk.bottom(to: releaseDateFrameImageView, attribute: .top, relation: .lessThanOrEqual, constant: -9)
        movieOverviewLabel.mrk.height(120)

        releaseDateView.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 12)
        releaseDateView.mrk.bottom(to: contentView, attribute: .bottom, relation: .equal, constant: -6)
        releaseDateView.mrk.width(61)
        releaseDateView.mrk.height(21)
    }
    
    /**
     Setting up Cell with Movie data.
     */
    func setup(with movie: Movie) {
        if let path = movie.posterPath, let url = URL(string: "\(Config.URL.basePosterList)\(path)") {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))]) { (_, _, _, _) in
                self.contentView.layoutIfNeeded()
            }
        }
        
        movieTitleLabel.text    = movie.title
        movieOverviewLabel.text = movie.overview ?? ""

        releaseDateView.setupWith(date: movie.releaseDate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        movieOverviewLabel.text = nil
    }
}
