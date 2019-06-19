//
//  WatchListCell.swift
//  MovieTime
//
//  Created by Nouf Aldoaij on 18/06/2019.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class WatchListCell: UITableViewCell {
    
    @IBOutlet weak var moviesPoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var moiveView: UIView!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie:DummyData?
    var delegate:UpdateWatchList?
    var favoriteListDelegate: UpdateFavoriteList?
    override func awakeFromNib() {
        super.awakeFromNib()
        moiveView.dropShadow()
    }
    
    @IBAction func addToWatchList(_ sender: UIButton) {
        UserPreferences().updateToWatchList(toWatch: false, movie: movie!)
        delegate?.updateWatchList()
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        UserPreferences().updateToFavoriteList(isAFavorited: false, movie: movie!)
        favoriteListDelegate?.updateFavoriteList()
    }
    
}
