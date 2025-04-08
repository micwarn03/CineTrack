//
//  NetworkObjects.swift
//  CineTrackTesting
//
//  Created by Shea Leech on 3/29/25.
//

import Foundation

//Struct to store the response for https://developer.themoviedb.org/reference/movie-details
struct MovieDetails : Codable, Identifiable {
    var genres:[Genre]
    var title:String
    var overview:String
    var runtime:Int
    var release_date:String
    var poster_path:String
    var id:Int32
}

//Struct to store the response for https://developer.themoviedb.org/reference/tv-series-details
struct TVSeriesDetails : Codable {
    var genres:[Genre]
    var name:String
    var overview:String
    var id:Int32
    var first_air_date:String
    var last_air_date:String
    var number_of_seasons:Int
    var poster_path:String
}

//Helper struct for above
struct Genre : Codable {
    var id:Int
    var name:String
}

//Struct to store the response for https://developer.themoviedb.org/reference/search-movie
//and https://developer.themoviedb.org/reference/search-tv
struct SearchResults : Codable {
    var page:Int
    var results:[result]
}
//Helper for above
struct result : Codable {
    var id:Int32
    var title:String
}

//Gets a movie by its id number and returns it
func getMovieByID(id: Int32) async -> MovieDetails? {
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
        return movie
    }
    catch{
        print(error)
    }
    return nil
}

func getTVSeriesByID(id: Int32) async -> TVSeriesDetails? {
    let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)")!
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
        let series = try decoder.decode(TVSeriesDetails.self, from:data)
        return series
    }
    catch{
        print(error)
    }
    return nil
}

//Searches for movies using TMDB's API and returns the array of results.
func searchForMovies(query: String) async -> [result]?{
    let url = URL(string: "https://api.themoviedb.org/3/search/movie")!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    let queryItems: [URLQueryItem] = [
        URLQueryItem(name: "query", value: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)),
      URLQueryItem(name: "include_adult", value: "false"),
      URLQueryItem(name: "language", value: "en-US"),
      URLQueryItem(name: "page", value: "1"),
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
        let searchresults = try decoder.decode(SearchResults.self, from: data)
        return searchresults.results
    }
    catch{
        print(error)
    }
    return nil
}

//Searches for TV shows using TMDB's API and returns the array of results.
func searchForTV(query: String) async -> [result]?{
    let url = URL(string: "https://api.themoviedb.org/3/search/tv")!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    let queryItems: [URLQueryItem] = [
        URLQueryItem(name: "query", value: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)),
      URLQueryItem(name: "include_adult", value: "false"),
      URLQueryItem(name: "language", value: "en-US"),
      URLQueryItem(name: "page", value: "1"),
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
        let searchresults = try decoder.decode(SearchResults.self, from: data)
        return searchresults.results
    }
    catch{
        print(error)
    }
    return nil
}

//Takes the poster path returned by the TMDB api and turns it into a full image url
//Note: I am making some assumptions about how TMDB stores and serves images (i.e. they
//do it always in the same way with the same initial bit of the url) but in my testing
//this has always worked to produce a link to an image.
func makeFullPosterPath(pathstub: String) -> String {
    
    return "https://image.tmdb.org/t/p/w1280\(pathstub)"
}

//Converts the API result struct into the SwiftData object
func convertMovieResult(result: MovieDetails) -> Movie {
    var genreNames = [String]()
    let releaseYear = String(result.release_date.prefix(4))
    
    for genre in result.genres {
        genreNames.append(genre.name)
    }
    
    return Movie(id: result.id, title: result.title, genres: genreNames, year: releaseYear, runtime: result.runtime, synopsis: result.overview, posterPath: makeFullPosterPath(pathstub: result.poster_path), mediaType: "Movie")
}

//Converts the API result struct into the SwiftData object
func convertTVResult(result: TVSeriesDetails) -> TVShow {
    var genreNames = [String]()
    var years = [String]()
    let firstYear = Int(String(result.first_air_date.prefix(4))) ?? 0
    let lastYear = Int(String(result.last_air_date.prefix(4))) ?? 0
    
    for year in firstYear...lastYear {
        years.append(String(year))
    }
    
    for genre in result.genres {
        genreNames.append(genre.name)
    }
    
    return TVShow(id: result.id, title: result.name, genres: genreNames, years: years, synopsis: result.overview, posterPath: makeFullPosterPath(pathstub: result.poster_path), mediaType: "TV Show", numSeasons: result.number_of_seasons)
}
