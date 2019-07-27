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
    var listOfMovies: [MovieEntity] = []
    var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var request:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioEngine = AVAudioEngine()
    var pageNumber = 1
    var feedback:UInt32 = 1519
    var edgeInsets:CGFloat = 55
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func setUI() {
        speechRecognizer?.delegate = self
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        searchBarView.setViewWithBorder()
        speechRecognizer?.delegate = self
    }
    
    func loadData() {
        if Connectivity.isConnectedToInternet {
            webserviceManager.instance.getMovies(page: pageNumber, classfication: "popular") { (success, movies ) in
                if success {
                    self.listOfMovies = movies!
                    self.tableView.reloadData()
                }
            }
        } else {
            HelperClass().showAlert(title: nil, message: "Please make sure you have your internet connection on", self)
        }
        
    }
    
    
    // Filtere the list of contacts base on the contact name
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            loadData()
        } else {
            webserviceManager.instance.searchForMovies(movieTitle: searchText) { (success, movies) in
                if success {
                    self.listOfMovies = movies!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // Load moives poster
    func getMoviePoster(_ imagePath: String , completion: @escaping (_ image: UIImage) -> Void ) -> Void {
        webserviceManager.instance.getMoviePoster(imagePath:imagePath) { (success, image) in
            if success {
                completion(image!)
            }
        }
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataFound.isEnabled = listOfMovies.count > 0 ? true : false
        return listOfMovies.count > 0 ? listOfMovies.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableCell
        let entity = listOfMovies[indexPath.row]
        cell.movie = entity
        cell.movieTitle.text = entity.title
        cell.movieGenres.text = entity.releaseDate
        if let image = webserviceManager.instance.cachedImage(for: entity.posterPath) {
            cell.moviePoster.image = image
            cell.moviesPosterData = image.pngData()
            print("image is being cached")
        } else {
            getMoviePoster(entity.posterPath) { (image) in
                cell.moviePoster.image = image
                cell.moviesPosterData = image.pngData()
                print("image is being download")
                
            }
        }
        
        if UserPreferences().isMovieInWatchList(title: entity.title) {
            cell.watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            cell.watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
        
        if UserPreferences().isMovieInFavoriteList(title: entity.title) {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
        } else {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movieID = String(listOfMovies[indexPath.row].id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchMoviesList(_ sender: UIButton) {
        AudioServicesPlaySystemSound(feedback) // Actuate "Peek" feedback (weak boom)
        if sender.currentImage == #imageLiteral(resourceName: "micrfo") {
            sender.setImage(#imageLiteral(resourceName: "mic"), for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: edgeInsets, left: edgeInsets, bottom: edgeInsets, right: edgeInsets)
            startRecording()
        } else {
            if audioEngine.isRunning {
                audioEngine.stop()
                request?.endAudio()
            }
            sender.setImage(#imageLiteral(resourceName: "micrfo"), for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            //try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        request = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = request else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.searchBar.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
                
                webserviceManager.instance.searchForMovies(movieTitle: (result?.bestTranscription.formattedString)!) { (success, movies) in
                    if success {
                        self.listOfMovies = movies!
                        self.tableView.reloadData()
                    } else {
                        HelperClass().showAlert(title: nil, message: "could n", self)
                    }
                }
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.request = nil
                self.recognitionTask = nil
                //self.startStopBtn.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.request?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
}
