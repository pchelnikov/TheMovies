//
//  Movie+Decodable.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

extension Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title       = "title"
        case overview    = "overview"
        case posterPath  = "poster_path"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title       = try? values.decode(String.self, forKey: .title)
        self.overview    = try? values.decode(String.self, forKey: .overview)
        self.posterPath  = try? values.decode(String.self, forKey: .posterPath)
        self.releaseDate = try? values.decode(String.self, forKey: .releaseDate)
    }
}
