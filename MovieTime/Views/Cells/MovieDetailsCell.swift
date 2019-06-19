//
//  MovieDetailsCell.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/16/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var addToWatchList: UIButton!
    @IBOutlet weak var addToFavorite: UIButton!
    @IBOutlet weak var movieDetails: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
