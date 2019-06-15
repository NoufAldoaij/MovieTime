//
//  DiscoverMoreVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/14/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class DiscoverMoreVC: UIViewController,UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    var moviesList:[DummyData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
        
    func setUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Discover More"
        //self.tabBarController?.tabBar.isHidden = true
        moviesList = StaticDataHelper().getAllMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count > 0 ? moviesList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableCell
        cell.movie =  moviesList[indexPath.row]
        cell.movieTitle.text = moviesList[indexPath.row].movieTitle
        cell.moviePoster.image = moviesList[indexPath.row].moviePoster
        cell.moviesReleaseDate.text = moviesList[indexPath.row].moviesReleaseDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
