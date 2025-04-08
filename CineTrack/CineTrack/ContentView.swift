//
//  ContentView.swift
//  CineTrack
//
//  Created by Shea Leech on 3/28/25.
//

import SwiftUI

struct ContentView: View {
    @State var movies: [Movie]
    @State var shows: [TVShow]
    @State var movieHistory: [Movie]
    @State var showHistory: [TVShow]
    @State var moviesList = true
    @State var searching = false
    @State var history = false
    
    var body: some View {
        NavigationStack {
            VStack{
                if !history {
                    if(moviesList){
                        List(movies) { movie in
                            NavigationLink {
                                //DetailPage(movie: movie)
                            } label: {
                                ListRow(movie: movie, isMovie: true)
                            }
                        }
                    }
                    else {
                        List(shows) { show in
                            NavigationLink {
                                //DetailPage(movie: movie)
                            } label: {
                                ListRow(show: show, isMovie: false)
                            }
                        }
                    }
                }
                else {
                    if(moviesList){
                        List(movieHistory) { movie in
                            NavigationLink {
                                //DetailPage(movie: movie)
                            } label: {
                                ListRow(movie: movie, isMovie: true)
                            }
                        }
                    }
                    else {
                        List(showHistory) { show in
                            NavigationLink {
                                //DetailPage(movie: movie)
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
                    NavigationLink {
                        Search(movieList:$movies, showList: $shows, movies: moviesList)
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
}

#Preview {
    ContentView(movies: [Movie(id: 1, title: "A Minecraft Movie", genres: ["Action"], year: "2025", runtime: 120, synopsis: "Overview", posterPath: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg", mediaType: "movie")], shows: [], movieHistory: [], showHistory: [])
}
