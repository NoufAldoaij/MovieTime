//
//  webserviceManager.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/21/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class webserviceManager {
    
    // Load moives data from the TMDb
    func getMovies(page:Int, classfication:String, completion: @escaping (_ success:Bool, _ moives:[MovieEntity]?) -> Void) -> Void {
        let url = GeneralValues.baseURL + classfication + GeneralValues.appKey + "page=\(page)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respones) in
            if respones.data != nil {
                do {
                    let decoder = JSONDecoder()
                    let webRespones = try decoder.decode(MoviesEntity.self, from: respones.data!)
                    completion (true, webRespones.results)
                } catch {
                    print("error \(error)")
                    completion (false,nil)
                }
            }
        }
    }
    
    // Load moives poster using the image path
    func getMoviePoster(imagePath:String, completion: @escaping (_ success:Bool, _ image:UIImage?) -> Void ) -> Void {
        let url = "https://image.tmdb.org/t/p/w500\(imagePath)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseImage { (respones) in
            if respones.data != nil {
                let webRespones = respones.result.value
                completion (true,webRespones)
            } else {
                completion (false,nil)
            }
        }
    }
}
