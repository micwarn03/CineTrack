//
//  ContentView.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query var allMovies: [Movie]
    @Query var allTVShows: [TVShow]
    
//    @State var movies: [Movie]
//    @State var shows: [TVShow]
//    @State var movieHistory: [Movie]
//    @State var showHistory: [TVShow]
    @State var moviesList = true
    @State var searching = false
    @State var history = false
    
    var body: some View {
        NavigationStack {
            VStack{
                if !history {
                    if (moviesList) {
                        List(filteredMovies(watched: false)) { movie in
                            NavigationLink {
                                DetailPage(movie: movie, show: nil, isMovie: true)
                            } label: {
                                ListRow(movie: movie, isMovie: true)
                            }
                        }
                    }
                    else {
                        List(filteredShows(watched: false)) { show in
                            NavigationLink {
                                DetailPage(movie: nil, show: show, isMovie: false)
                            } label: {
                                ListRow(show: show, isMovie: false)
                            }
                        }
                    }
                }
                else {
                    if(moviesList){
                        List(filteredMovies(watched: true)) { movie in
                            NavigationLink {
                                DetailPage(movie: movie, show: nil, isMovie: true)
                            } label: {
                                ListRow(movie: movie, isMovie: true)
                            }
                        }
                    }
                    else {
                        List(filteredShows(watched: true)) { show in
                            NavigationLink {
                                DetailPage(movie: nil, show: show, isMovie: false)
                            } label: {
                                ListRow(show: show, isMovie: false)
                            }
                        }
                    }
                }
                Spacer()
                //Will style to make buttons look better later 
                HStack{
                    Spacer()
                    Button("History"){
                        history.toggle()
                    }
                    Spacer()
//                    NavigationLink {
//                        Search(movieList:$movies, showList: $shows, movies: moviesList)
//                    } label: {
//                        Text("Search")
//                    }
                    NavigationLink {
                        Search(movies: moviesList)
                    } label: {
                        Text("Search")
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle(history ? "Watch History" : moviesList ? "Movie Watchlist" : "TV Show Watchlist")
            .toolbar {
                Button("Switch Media Type", systemImage: "arrow.trianglehead.2.clockwise"){
                    moviesList.toggle()
                }
            }
        }
        
    }
    
    private func filteredMovies(watched: Bool) -> [Movie] {
        allMovies.filter { watched ? $0.dateWatched != nil : $0.dateWatched == nil}
    }
    
    private func filteredShows(watched: Bool) -> [TVShow] {
        allTVShows.filter { watched ? $0.dateWatched != nil : $0.dateWatched == nil}
    }
}

#Preview {
    ContentView(/*movies: [Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie")], shows: [], movieHistory: [], showHistory: []*/)
}
