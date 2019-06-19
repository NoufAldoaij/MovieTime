//
//  FavoriteListVC.swift
//  MovieTime
//
//  Created by Nouf Aldoaij on 18/06/2019.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UpdateFavoriteList {
    
    
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var favoriteList: [FavoriteList]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.favoriteList
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataFound: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func setUI() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBarView.setViewWithBorder()
        noDataFound.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataFound.isHidden = favoriteList.count > 0 ? true : false
        return favoriteList.count > 0 ? favoriteList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WatchListCell
        cell.movie =  favoriteList[indexPath.row].movieInfo
        cell.favoriteListDelegate = self
        cell.moviesPoster.image = favoriteList[indexPath.row].movieInfo?.moviePoster
        cell.movieTitle.text = favoriteList[indexPath.row].movieInfo?.movieTitle
        cell.movieGenres.text = "2019 Action,Thriller"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    func updateFavoriteList() {
        tableView.reloadData()
    }
    
}
