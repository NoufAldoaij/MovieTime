//
//  MovieDetailsVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/16/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import Foundation
class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var overviewLable: UILabel!
    @IBOutlet weak var watchListBtn: UIButton!
    @IBOutlet weak var favoritesList: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies:MovieDetailsEntity?
    var imageData:Data?
    var movieID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        setUI()
    }
    
    func loadData() {
        activityIndicator.startAnimating()
        webserviceManager().getMoiveDetails(id:movieID) { (success, MovieDetails) in
            if success {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
                self.movies = MovieDetails
                self.setUI()
                self.getMoviePoster(self.movies!.posterPath!) { (image) in
                    self.imageData = image.pngData()!
                }
            } else {
                self.activityIndicator.startAnimating()
                 self.activityIndicator.hidesWhenStopped = true
                HelperClass().showAlert(title: nil, message: "Could not load moives details", self)
            }
        }
    }
    
    func setUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        if movies != nil {
            title = self.movies?.originalTitle
            overviewLable.text = self.movies?.overview
            // if the movies does not belong to collection use the image from the poster path
            if movies?.belongsToCollection != nil {
                getMoviePoster(movies!.belongsToCollection!.posterPath!) { (image) in
                   self.backgroundView.image = image
                }
            } else {
                getMoviePoster(movies!.posterPath!) { (image) in
                    self.backgroundView.image = image
                }
            }
            
            if UserPreferences().isMovieInFavoriteList(title: movies!.title!) {
                favoritesList.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            } else {
                favoritesList.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
            }
            
            if UserPreferences().isMovieInWatchList(title: movies!.title!) {
                watchListBtn.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
            } else {
                watchListBtn.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
            }
        }
        
    }
    
    func getMoviePoster(_ imagePath: String , completion: @escaping (_ image: UIImage) -> Void ) -> Void {
        webserviceManager().getMoviePoster(imagePath:imagePath) { (success, image) in
            if success {
                completion(image!)
            }
        }
    }
  
    
    @IBAction func updateWatchList(_ sender: UIButton) {
        if let movies = movies {
            if sender.currentImage == #imageLiteral(resourceName: "bookmark") {
                watchListBtn.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
                UserPreferences().addToWatchList(String(movies.id),movies.title!, movies.releaseDate!, imageData!)
            } else {
                watchListBtn.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
               UserPreferences().removeFromWatchList(movies.title!, movies.releaseDate!)
            }
           
        }
    }
    
    @IBAction func updateFavoritesList(_ sender: UIButton) {
        if let movies = movies {
            if sender.currentImage == #imageLiteral(resourceName: "hearts") {
                favoritesList.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
                UserPreferences().addToFavoriteList(String(movies.id),movies.title!, movies.releaseDate!, imageData!)
            } else {
                favoritesList.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
                UserPreferences().removeFavoriteList(movies.title!, movies.releaseDate!)
            }
        }
    }
}
