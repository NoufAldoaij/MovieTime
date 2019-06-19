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
    var listOfMovies:[DummyData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
        
    func setUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Discover More"
        listOfMovies = StaticDataHelper().getAllMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count > 0 ? listOfMovies.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableCell
        cell.movie =  listOfMovies[indexPath.row]
        cell.movieTitle.text = listOfMovies[indexPath.row].movieTitle
        cell.moviePoster.image = listOfMovies[indexPath.row].moviePoster
        cell.moviesReleaseDate.text = listOfMovies[indexPath.row].moviesReleaseDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movies = listOfMovies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
