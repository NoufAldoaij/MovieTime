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

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}



class webserviceManager {
    
    //let imageCache = AutoPurgingImageCache()
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    static let instance = webserviceManager()
    
    
    // Load moives data from the TMDb
    func getMovies(page:Int, classfication:String, completion: @escaping (_ success:Bool, _ moives:[MovieEntity]?) -> Void) -> Void {
        if Connectivity.isConnectedToInternet {
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
        } else {
            completion (false,nil)
        }
        
    }
    func searchForMovies(movieTitle:String, completion: @escaping (_ success:Bool, _ moives:[MovieEntity]?)->Void)->Void {
        if Connectivity.isConnectedToInternet {
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
        } else {
            completion (false,nil)
            
        }
    }
    
    // Load moives poster using the image path
    func getMoviePoster(imagePath:String, completion: @escaping (_ success:Bool, _ image:UIImage?) -> Void ) -> Void {
        if Connectivity.isConnectedToInternet {
            let url = "https://image.tmdb.org/t/p/w500\(imagePath)"
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseImage { (respones) in
                if respones.data != nil {
                    let webRespones = respones.result.value
                    self.cache(webRespones!, for: imagePath)
                    completion (true,webRespones)
                } else {
                    completion (false,nil)
                }
            }
        } else {
            completion (false,nil)
            
        }
    }
    
    func cache(_ image: Image, for url: String) {
        let urlRequest = URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")!)
        imageCache.add(image, for: urlRequest, withIdentifier: url)
        //imageCache.add(image, withIdentifier: fullUrl)
    }
    
    func cachedImage(for url: String) -> UIImage? {
        let urlRequest = URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)")!)
        let cachedImage = imageCache.image(for: urlRequest, withIdentifier: url)
        return cachedImage
    }
    
    func getMoiveDetails(id:String ,completion: @escaping (_ success:Bool, _ movieDetails:MovieDetailsEntity?)-> Void ) -> Void {
        if Connectivity.isConnectedToInternet {
            let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=509b34d4511a611531da850d085d71a3&language=en-US"
            print("url: \(url)")
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respones) in
                if respones.data != nil {
                    let decoder = JSONDecoder()
                    do {
                        let webRespones = try decoder.decode(MovieDetailsEntity.self, from: respones.data!)
                        completion (true,webRespones)
                    } catch {
                        print("error \(error) and \(error.localizedDescription)")
                        completion (false,nil)
                    }
                } else {
                    completion (false,nil)
                }
            }
        } else {
            completion (false,nil)
            
        }
    }
}


extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
    
}

