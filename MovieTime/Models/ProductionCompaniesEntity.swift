//
//  ProductionCompaniesEntity.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/26/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

class ProductionCompaniesEntity: Codable {
    let name: String?
    let logoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case logoPath = "logo_path"
    }
}



