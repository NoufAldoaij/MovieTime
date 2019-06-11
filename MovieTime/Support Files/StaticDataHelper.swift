//
//  StaticDataHelper.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/11/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

public class StaticDataHelper : NSObject {
    
    var listOfMovies: [DummyData] = []
    
    func getAllMovies() -> [DummyData]{
        if listOfMovies.count == 0{
            let movie1 = DummyData.init(moviePoster: #imageLiteral(resourceName: "d1pklzbuyaab0la-1552597012"), movieTitle:"Avenger End Game")
            let movie2 = DummyData.init(moviePoster: #imageLiteral(resourceName: "X-Men-Dark-Phoenix-New-Poster_1200_1777_81_s"), movieTitle:"X Men Dark Phoenix")
            let movie3 = DummyData.init(moviePoster: #imageLiteral(resourceName: "images"), movieTitle:"Moonlight")
            let movie4 = DummyData.init(moviePoster: #imageLiteral(resourceName: "f24a35e9bf4306ffd54a4e75e228586a_500x735"), movieTitle:"The Great Showman")
            let movie5 = DummyData.init(moviePoster: #imageLiteral(resourceName: "ac2f58d9275e2399279c1fda4220178c"), movieTitle:"Blade Runner")
            let movie6 = DummyData.init(moviePoster: #imageLiteral(resourceName: "Movie-Poster-Template-Dark-with-Image"), movieTitle:"Movie Title")
            let movie7 = DummyData.init(moviePoster: #imageLiteral(resourceName: "images-1"), movieTitle:"Boo 2")
            let movie8 = DummyData.init(moviePoster: #imageLiteral(resourceName: "3e89c3b546493a16a9b569006ee64604"), movieTitle:"Ant Man")
            let movie9 = DummyData.init(moviePoster: #imageLiteral(resourceName: "maze-runner-the-death-cure-movie-poster-md"), movieTitle:"Maze Runner")
            let movie10 = DummyData.init(moviePoster: #imageLiteral(resourceName: "medium-black-panther-movie-poster-mp0085-original-imaf3sqtabyhq7kb"), movieTitle:"Black Panther")

            listOfMovies.append(movie1)
            listOfMovies.append(movie2)
            listOfMovies.append(movie3)
            listOfMovies.append(movie4)
            listOfMovies.append(movie5)
            listOfMovies.append(movie6)
            listOfMovies.append(movie7)
            listOfMovies.append(movie8)
            listOfMovies.append(movie9)
            listOfMovies.append(movie10)

        }
        return listOfMovies
    }
    
}
