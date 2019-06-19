//
//  MovieDetailsVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/16/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    var movies:DummyData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

    }
    
    func setUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = movies?.movieTitle
        moviePoster.image = movies?.moviePoster
    }
}
