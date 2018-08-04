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
        static let posterDefaultWidth: CGFloat = 185 / 2
        static let posterDefaultHeight: CGFloat = 278 / 2
    }
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let movieTitleLabel = UILabel(font: UIFont.systemFont(ofSize: 16), color: .primaryColor, lines: 0, alignment: .left)
    private let movieReleaseDateLabel = UILabel(font: UIFont.systemFont(ofSize: 12), color: .black, lines: 1, alignment: .left)
    private let movieOverviewLabel = UILabel(font: UIFont.systemFont(ofSize: 12), color: .black, lines: 0, alignment: .left)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieReleaseDateLabel)
        contentView.addSubview(movieOverviewLabel)
    }
    
    private func setupConstraints() {
        posterImageView.mrk.top(to: contentView, attribute: .top, relation: .equal, constant: 10)
        posterImageView.mrk.leading(to: contentView, attribute: .leading, relation: .equal, constant: 10)
        posterImageView.mrk.width(Sizes.posterDefaultWidth)
        posterImageView.mrk.height(Sizes.posterDefaultHeight)
        posterImageView.mrk.bottom(to: contentView, attribute: .bottom, relation: .lessThanOrEqual, constant: -20)
        
        posterImageView.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
        
        movieTitleLabel.mrk.top(to: posterImageView, attribute: .top, relation: .equal, constant: 0)
        movieTitleLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 10)
        movieTitleLabel.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -10)
        
        movieReleaseDateLabel.mrk.top(to: movieTitleLabel, attribute: .bottom, relation: .equal, constant: 4)
        movieReleaseDateLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 10)
        movieReleaseDateLabel.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -10)
        
        movieOverviewLabel.mrk.top(to: movieReleaseDateLabel, attribute: .bottom, relation: .equal, constant: 4)
        movieOverviewLabel.mrk.leading(to: posterImageView, attribute: .trailing, relation: .equal, constant: 10)
        movieOverviewLabel.mrk.trailing(to: contentView, attribute: .trailing, relation: .equal, constant: -10)
        movieOverviewLabel.mrk.bottom(to: contentView, attribute: .bottom, relation: .lessThanOrEqual, constant: -20)
    }
    
    /**
     Setting up Cell with Movie data.
     */
    func setup(with movie: Movie) {
        if let path = movie.posterPath, let url = URL(string: "\(Config.URL.basePoster)\(path)") {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { (_, _, _, _) in
                self.contentView.layoutIfNeeded()
            }
        }
        
        movieTitleLabel.text       = movie.title
        movieReleaseDateLabel.text = "Release Date: \(movie.releaseDate ?? "")"
        movieOverviewLabel.text    = "Overview: \(movie.overview ?? "")"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
}
