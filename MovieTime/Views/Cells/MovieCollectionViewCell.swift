//
//  MovieCollectionViewCell.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/8/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import CoreData
class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviesPoster: UIImageView!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    var movie: MovieEntity?
    var moviesPosterData: Data?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Save or remove movie to the watch list
    @IBAction func updateWatchList(_ sender: UIButton) {
        if watchListButton.currentImage == #imageLiteral(resourceName: "bookmark") {
            UserPreferences().addToWatchList(movie!,moviesPosterData!)
            watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            UserPreferences().removeFromWatchList(movie!.title!, movie!.releaseDate!)
            watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
    }
   
    // Save or remove movie from favorites list
    @IBAction func updateFavoritesList(_ sender: Any) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "hearts") {
            UserPreferences().addToFavoriteList(movie!, moviesPosterData!)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
        } else {
            UserPreferences().removeFavoriteList(movie!.title!, movie!.releaseDate!)
            favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
    }
}
