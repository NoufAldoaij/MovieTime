//
//  MovieTableCell.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/12/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var moiveView: UIView!
    @IBOutlet weak var moviesReleaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    var movie:MovieEntity?
    var moviesPosterData: Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moiveView.dropShadow()
    }
    
    // Save or remove movie to the watch list
    @IBAction func updateWatchList(_ sender: UIButton) {
        if watchListButton.currentImage == #imageLiteral(resourceName: "bookmark") {
            UserPreferences().addToWatchList(String(movie!.id), movie!.title, movie!.releaseDate , moviesPosterData!)
            
            watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            UserPreferences().removeFromWatchList(movie!.title, movie!.releaseDate)
            watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
    }
    
    // Save or remove movie from favorites list
    @IBAction func updateFavoritesList(_ sender: UIButton) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "hearts") {
            UserPreferences().addToFavoriteList(String(movie!.id), movie!.title, movie!.releaseDate , moviesPosterData!)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
        } else {
            UserPreferences().removeFavoriteList(movie!.title, movie!.releaseDate)
            favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
    }
}
