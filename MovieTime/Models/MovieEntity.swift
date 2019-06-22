//
//  MovieEntity.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/21/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

class MovieEntity:Codable {
    
    let voteAverage: Double
    let title: String?
    let posterPath: String?
    let releaseDate: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
}

