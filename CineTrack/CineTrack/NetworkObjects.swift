//
//  NetworkObjects.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import Foundation

struct MovieDetails : Codable {
    var genres:[genre]?
    var title:String?
    var overview:String?
    var runtime:Int?
    var releaase_date:String?
    var poster_path:String?
    var id:Int32
    
}

struct genre : Codable {
    var id:Int?
    var name:String?
}

//Temporary test function, gets a movie by its id number and prints it
//will later be updated to return the movie object and hook into another
//function which will create the SwiftData version of the movie
func getMovieByID(id: Int32) async {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)")!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    let queryItems: [URLQueryItem] = [
      URLQueryItem(name: "language", value: "en-US"),
    ]
    components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.allHTTPHeaderFields = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMGIyOWQ1N2VhZTEzZDVhNjA5OTlhMjY1NmIxMWNkNiIsIm5iZiI6MTc0MTAzNjUzNS4wNzksInN1YiI6IjY3YzYxYmY3YzdjYWJhNDI0YzkyMWM5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.njE9u0pa6jnTpIW8R0O-t2stVbi8Zw2_pp551hCQsqg"
    ]

    do{
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let movie = try decoder.decode(MovieDetails.self, from:data)
        print(movie)
        //print(String(decoding: data, as: UTF8.self))
    }
    catch{
        print(error)
    }
}
