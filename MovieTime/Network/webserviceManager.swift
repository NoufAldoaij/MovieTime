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
            } else {
                completion (false,nil)
            }
        }
    }
    func searchForMovies(movieTitle:String, completion: @escaping (_ success:Bool, _ moives:[MovieEntity]?)->Void)->Void {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=509b34d4511a611531da850d085d71a3&query=\(movieTitle)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respones) in
            if respones.data != nil {
                let decoder = JSONDecoder()
                do {
                    let webRespones = try decoder.decode(MoviesEntity.self, from: respones.data!)
                    completion (true,webRespones.results)
                } catch {
                    completion (false,nil)
                }
                
            } else {
                completion (false,nil)
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
    
    func getMoiveDetails(id:String ,completion: @escaping (_ success:Bool, _ movieDetails:MovieDetailsEntity?)-> Void ) -> Void {
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=509b34d4511a611531da850d085d71a3&language=en-US"
        print("url: \(url)")
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respones) in
            if respones.data != nil {
                let decoder = JSONDecoder()
                do {
                    let webRespones = try decoder.decode(MovieDetailsEntity.self, from: respones.data!)
//                   //
//                    print("webRespones.belongsToCollection.name \(webRespones.belongsToCollection!.posterPath)")
                    completion (true,webRespones)
                } catch {
                    print("error \(error) and \(error.localizedDescription)")
                    completion (false,nil)
                }
            } else {
                completion (false,nil)
            }
        }
        
    }
}
