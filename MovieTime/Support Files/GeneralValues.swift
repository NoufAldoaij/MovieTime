//
//  GeneralValues.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/21/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
class GeneralValues {
    
    static var appKey : String = HelperClass().getAppConfigValue(Key: "AppKey") as! String
    static var baseURL : String = HelperClass().getAppConfigValue(Key: "Base_URL") as! String
    
}
