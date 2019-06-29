//
//  BelongsToCollectionEntity.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/26/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

class BelongsToCollectionEntity: Codable {
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}


