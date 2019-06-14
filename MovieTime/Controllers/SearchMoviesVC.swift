//
//  SearchMoviesVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/11/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import Speech
class SearchMoviesVC: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,SFSpeechRecognizerDelegate
 {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataFound: UILabel!
    let refreshControl = UIRefreshControl()
    var listOfMovies:[DummyData] = []
    var filteredData : Array<DummyData>?
    
    var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var request:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initValue()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        speechRecognizer?.delegate = self
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        searchBarView.setViewWithBorder()
        listOfMovies = StaticDataHelper().getAllMovies()
        filteredData = listOfMovies
    }
    
    func initValue() -> Void {
        refreshControl.addTarget(self, action: #selector(SearchMoviesVC.refreshData), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = MovieTimeColors.darkPink_Color
        tableView.refreshControl = refreshControl
        self.tableView.contentOffset = CGPoint(x:0, y:-self.refreshControl.frame.size.height)
    }
    
    //Loading new contacts after refresh the screen
    @objc func refreshData() {
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.text = ""
        refreshControl.beginRefreshing()
    }
    
    //Filtere the list of contacts base on the contact name
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = listOfMovies
            tableView.reloadData()
            return
        }
        
        filteredData = listOfMovies.filter() { $0.movieTitle == searchText }
        tableView.reloadData()
    }
    
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataFound.isEnabled = filteredData!.count > 0 ? true : false
        return filteredData!.count > 0 ? filteredData!.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableCell
        cell.movie = filteredData![indexPath.row]
        cell.moviePoster.image = filteredData![indexPath.row].moviePoster
        cell.movieTitle.text = filteredData![indexPath.row].movieTitle
        cell.movieGenres.text = "2019 Action,Thriller"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    @IBAction func searchMoviesList(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "micrfo") {
            sender.setImage(#imageLiteral(resourceName: "mic"), for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 55, left: 55, bottom: 55, right: 55)
                HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
        } else {
            sender.setImage(#imageLiteral(resourceName: "micrfo"), for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
