//
//  MoviesEntity.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/21/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

class MoviesEntity: Codable {
    
    let results: [MovieEntity]? 
    let page: Int
}
